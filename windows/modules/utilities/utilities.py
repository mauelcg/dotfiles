import argparser
from create import *

if __name__ == '__main__':
    # filename = str(uuid.uuid4())
    # os.makedirs(filename)

    parser = argparser.parse()
    args = parser.parse_args()

    if args.utilities_subparser == 'create':
        create(args.path, is_random=args.random, is_directory=args.directory)

# if random:
#     # https://stackoverflow.com/questions/10501247/best-way-to-generate-random-file-names-in-python
#     filename = str(uuid.uuid4())
#     os.makedirs(filename)
