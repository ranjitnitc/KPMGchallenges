from get_metadata import get_metadata


# https://stackoverflow.com/questions/9807634/find-all-occurrences-of-a-key-in-nested-python-dictionaries-and-lists
def get_nested_object_value(data, key):
    try:
        for k, v in data.items():
            if k == key:
                return v
            elif isinstance(v, dict):
                value = get_nested_object_value(v, key)
                if value is not None:
                    return value
    except AttributeError:
        return None


def find_key(key):
    metadata = get_metadata()
    print("Type:", type(metadata))
    return get_nested_object_value(metadata, key)


if __name__ == '__main__':
    key = input("What key would you like to find?")
    print(find_key(key))