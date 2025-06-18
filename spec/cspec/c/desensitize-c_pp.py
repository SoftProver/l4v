#!/usr/bin/env python
"""Tool to convert absolute paths to relative paths in C preprocessor directives."""

import os
import re
import sys

# Global variable for project root (to be set by user)
VERIFICATION_ROOT = os.path.abspath(
    os.path.join(os.path.dirname(__file__), *([".."] * 4))
)


def process_file(file_path: str, out_path: str) -> None:
    """
    Process a single file, converting absolute paths to relative paths.

    Args:
        file_path: Path to the file to process
    """
    with open(file_path, "r+") as f:
        content = f.read()
    converted = re.sub(
        r'^#\s*(\d+)\s+"([^"]+)"\s*(\d*)$',
        lambda m: (
            f"# {m.group(1)} "
            f'"{os.path.relpath(m.group(2), VERIFICATION_ROOT) if m.group(2).startswith(VERIFICATION_ROOT) else m.group(2)}" '
            f"{m.group(3)}"
        ).strip(),
        content,
        flags=re.MULTILINE,
    )
    ## Write the converted content to the output file
    with open(out_path, "w") as out_f:
        out_f.write(converted)

        # f.seek(0)
        # f.write(converted)
        # f.truncate()


def main() -> None:
    """Main entry point for the CLI tool."""
    if len(sys.argv) != 3:
        print(f"Usage: {sys.argv[0]} <input_file> <output_file>", file=sys.stderr)
        sys.exit(1)

    if not VERIFICATION_ROOT:
        print(
            "Error: VERIFICATION_ROOT must be set to project root path", file=sys.stderr
        )
        sys.exit(1)

    try:
        process_file(sys.argv[1], sys.argv[2])
    except Exception as e:
        print(f"Error processing {sys.argv[1]}: {str(e)}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
