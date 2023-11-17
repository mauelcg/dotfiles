from configparser import ConfigParser

if __name__ == '__main__':
    parser = ConfigParser()
    parser.read('config.ini')

    # Get all the path of all entry point in all modules
    for module in parser.items('modules'):
        print(module[1])
