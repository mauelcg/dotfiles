import argparse

def parse():
    parser = argparse.ArgumentParser(prog='utilities.py')

    # Initialize subparsers
    subparsers = parser.add_subparsers(title='subcommands', description='valid subcommands', help='additional help', dest='utilities_subparser')

    # Create `create` parser
    parser_create = subparsers.add_parser('create', help='create help')
    parser_create.add_argument('--path', type=str, default='.', help='the path where the file or directory to be created is located')
    parser_create.add_argument('-r', '--random', action='store_true', help='create with a randomly generated name')
    parser_create.add_argument('-d', '--directory', action='store_true', help='create directory instead of file')

    return parser
