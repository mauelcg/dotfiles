import os
import uuid

def create(path:str, is_random:bool, is_directory:bool, name:str = 'base'):
    message = 'Creating `base`'
    if is_random:
        name = str(uuid.uuid4())
        message = 'Creating randomly generated ' + ('directory' if is_directory else 'file') + 'name'

    print(message)

    if is_directory:
        os.makedirs(os.path.join(path, name))
    else:
        with open(f'{os.path.join(path, name)}.txt', 'w') as file:
            file.write('Hello World')
