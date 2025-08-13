#!/usr/bin/env python3
"""
Convert Valve Developer Wiki dump to Squirrel key-value structure for VScript API documentation.
"""

import re
import argparse
import sys
from typing import Dict, List, Optional, Tuple


class WikiToSquirrelConverter:
    def __init__(self):
        # Patterns for parsing
        self.class_pattern = re.compile(r'^===\s*([A-Za-z][A-Za-z0-9_, ]*[A-Za-z0-9_])\s*===$', re.MULTILINE)
        self.code_pattern = re.compile(r'<code>(.*?)</code>')
        self.template_pattern = re.compile(r'\{\{(note|warning|bug|tip|todo|important)\|(.*?)\}\}', re.DOTALL | re.IGNORECASE)
        self.function_signature_pattern = re.compile(r'^(.*?)\s+(\w+)\((.*?)\)$')
        self.row_separator_pattern = re.compile(r'^\|-(?!.*position:sticky).*$')  # Exclude sticky headers
        self.table_cell_pattern = re.compile(r'^\|\s*(.*?)$')
        self.table_start_pattern = re.compile(r'^\{\|.*class="standard-table".*$')
        self.table_end_pattern = re.compile(r'^\|\}\s*$')
        
    def replace_code_blocks(self, text: str) -> str:
        """Replace <code></code> blocks with single quotes."""
        return self.code_pattern.sub(r"'\1'", text)

    def extract_templates(self, text: str) -> Tuple[str, Dict[str, List[str]]]:
        """Extract template blocks and return cleaned text with template data."""
        templates = {}
        
        def replace_template(match):
            template_type = match.group(1).lower()
            content = match.group(2).strip()
            content = self.replace_code_blocks(content)
            
            if template_type not in templates:
                templates[template_type] = []
            templates[template_type].append(content)
            return ""
        
        cleaned_text = self.template_pattern.sub(replace_template, text)
        
        # Clean up any remaining fragments
        cleaned_text = re.sub(r'\{\{[^}]*$', '', cleaned_text)
        cleaned_text = re.sub(r'^[^{]*\}\}', '', cleaned_text)
        cleaned_text = re.sub(r'\|\}.*$', '', cleaned_text)
        
        return cleaned_text.strip(), templates

    def count_parameters(self, signature: str) -> int:
        """Count parameters in a function signature."""
        # Extract content within parentheses
        paren_match = re.search(r'\((.*?)\)', signature)
        if not paren_match:
            return 0
        
        params_str = paren_match.group(1).strip()
        if not params_str or params_str.lower() == 'void':
            return 0
        
        # Split by comma and count non-empty parameters
        params = [p.strip() for p in params_str.split(',') if p.strip()]
        return len(params)

    def parse_class_section(self, content: str, class_name: str) -> Dict[str, Dict]:
        """Parse a single class section to extract functions."""
        functions = {}
        
        # Split content into lines
        lines = content.split('\n')
        
        # Look for standard-table sections within this class
        current_idx = 0
        while current_idx < len(lines):
            line = lines[current_idx].strip()
            
            # Check for table start
            if self.table_start_pattern.match(line):
                # Parse the entire table
                table_functions, next_idx = self.parse_table(lines, current_idx)
                functions.update(table_functions)
                if class_name == "CEntities":
                    print(f"    Found {len(table_functions)} functions in table")
                current_idx = next_idx
            else:
                current_idx += 1
        
        return functions

    def parse_table(self, lines: List[str], start_idx: int) -> Tuple[Dict[str, Dict], int]:
        """Parse an entire MediaWiki table and extract all functions."""
        functions = {}
        current_idx = start_idx + 1  # Skip the table start line
        
        while current_idx < len(lines):
            line = lines[current_idx].strip()
            
            # Check for table end
            if self.table_end_pattern.match(line):
                break
            
            # Check for table row separator (but not sticky headers)
            if self.row_separator_pattern.match(line):
                # Parse this row
                function_data, next_idx = self.parse_table_row(lines, current_idx + 1)
                if function_data:
                    functions.update(function_data)
                    # print(f"      Parsed function: {list(function_data.keys())[0]}")
                else:
                    print(f"      No function data from row at line {current_idx}: {line}")
                current_idx = next_idx
            else:
                current_idx += 1
        
        return functions, current_idx + 1

    def parse_table_row(self, lines: List[str], start_idx: int) -> Tuple[Optional[Dict], int]:
        """Parse a single table row and extract function information."""
        if start_idx >= len(lines):
            return None, start_idx
        
        cells = []
        current_cell = ""
        current_idx = start_idx
        
        while current_idx < len(lines):
            line = lines[current_idx].strip()
            
            # Check if we've hit the next row, table end, or new section
            if (self.row_separator_pattern.match(line) or 
                self.table_end_pattern.match(line) or 
                line.startswith('===') or
                line.startswith('|-')):  # Any |- marks end of current row
                # Save the current cell if we have content
                if current_cell.strip():
                    cells.append(current_cell.strip())
                break
            
            # Check for table cell start
            cell_match = self.table_cell_pattern.match(line)
            if cell_match:
                # Save previous cell if we have content
                if current_cell.strip():
                    cells.append(current_cell.strip())
                # Start new cell
                current_cell = cell_match.group(1)
            elif line and not line.startswith('!'):  # Skip header rows that start with !
                # Continuation of current cell
                if current_cell:
                    current_cell += " " + line
                elif cells:  # If no current cell but we have cells, add to last cell
                    cells[-1] += " " + line
            
            current_idx += 1
        
        # Don't forget the last cell
        if current_cell.strip():
            cells.append(current_cell.strip())
        
        # Debug: print cell count and first few cells
        # if len(cells) > 0:
            # print(f"        Found {len(cells)} cells: {cells[:3] if len(cells) >= 3 else cells}")
        
        # Need at least 2 cells (function name and signature)
        if len(cells) < 2:
            print(f"        Not enough cells ({len(cells)}) for function")
            return None, current_idx
        
        function_name_cell = cells[0]
        function_signature_cell = cells[1]
        description_cell = cells[2] if len(cells) > 2 else ""
        
        # Extract function name
        function_name = self.replace_code_blocks(function_name_cell).strip("'")
        if not function_name or not re.match(r'^[A-Za-z_][A-Za-z0-9_]*$', function_name):
            return None, current_idx
        
        # Process signature
        signature = self.replace_code_blocks(function_signature_cell)
        param_count = self.count_parameters(signature)
        
        # Process description and extract templates
        description = self.replace_code_blocks(description_cell)
        clean_description, templates = self.extract_templates(description)
        
        # Build function data
        function_data = {
            "info": signature,
            "args": param_count,
            "description": clean_description
        }
        
        # Add template arrays
        for template_type, template_list in templates.items():
            function_data[template_type] = template_list
        
        return {function_name: function_data}, current_idx

    def convert(self, content: str) -> Dict:
        """Convert the entire wiki content to Squirrel structure."""
        script_functions = {}
        
        # Split content into class sections
        class_sections = self.class_pattern.split(content)
        
        # Process each class section
        for i in range(1, len(class_sections), 2):  # Skip the first part (before first class)
            if i + 1 < len(class_sections):
                class_name = class_sections[i].strip()
                class_content = class_sections[i + 1]
                
                # Only process classes that look like script classes (starting with 'C' or known names)
                if (class_name.startswith('C') or class_name in ['Vector', 'QAngle', 'Vector2D', 'Vector4D', 'Quaternion']):
                    print(f"Processing {class_name}...")
                    # Debug output removed for cleaner operation
                    functions = self.parse_class_section(class_content, class_name)
                    if functions:
                        print(f"  Found {len(functions)} functions in {class_name}")
                        script_functions[class_name] = functions
                    else:
                        print(f"  No functions found in {class_name}")
        
        return {"ScriptFunctions": script_functions}

    def format_squirrel_value(self, value, indent_level: int = 0) -> str:
        """Format a Python value as Squirrel syntax."""
        indent = "    " * indent_level
        
        if isinstance(value, dict):
            if not value:
                return "{}"
            
            lines = ["{"]
            for key, val in value.items():
                formatted_val = self.format_squirrel_value(val, indent_level + 1)
                lines.append(f"{indent}    {key} = {formatted_val}")
            lines.append(f"{indent}}}")
            return "\n".join(lines)
        
        elif isinstance(value, list):
            if not value:
                return "[]"
            
            formatted_items = []
            for item in value:
                if isinstance(item, str):
                    escaped_item = item.replace('"', '\\"')
                    formatted_items.append(f'"{escaped_item}"')
                else:
                    formatted_items.append(str(item))
            
            if len(formatted_items) == 1:
                return f"[{formatted_items[0]}]"
            else:
                lines = ["["]
                for item in formatted_items:
                    lines.append(f"{indent}    {item}")
                lines.append(f"{indent}]")
                return "\n".join(lines)
        
        elif isinstance(value, str):
            escaped_value = value.replace('"', '\\"')
            return f'"{escaped_value}"'
        
        elif isinstance(value, int):
            return str(value)
        
        else:
            return str(value)


def main():
    parser = argparse.ArgumentParser(description="Convert Valve Developer Wiki dump to Squirrel")
    parser.add_argument("input_file", help="Input wiki dump file (.md)")
    parser.add_argument("output_file", nargs='?', default="script_functions.nut", help="Output Squirrel file")
    
    args = parser.parse_args()
    
    try:
        with open(args.input_file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        print(f"Reading {args.input_file}...")
        
        converter = WikiToSquirrelConverter()
        result = converter.convert(content)
        
        # Generate Squirrel code
        squirrel_code = converter.format_squirrel_value(result)
        
        with open(args.output_file, 'w', encoding='utf-8') as f:
            f.write(squirrel_code)
        
        print(f"Successfully converted to {args.output_file}")
        
        # Print stats
        total_classes = len(result.get("ScriptFunctions", {}))
        total_functions = sum(len(class_funcs) for class_funcs in result.get("ScriptFunctions", {}).values())
        print(f"Processed {total_classes} classes with {total_functions} functions")
        
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
