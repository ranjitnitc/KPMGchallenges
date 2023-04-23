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

   
my_data = {
    "foo": { "bar": { "baz": 42 } }
}

if __name__ == '__main__':
    key_input=input("please key in the input:")

    if '/' in key_input:
        key_input = key_input.rsplit('/', 1)[-1]

    value = get_nested_object_value(my_data, key_input)
    if value is None:
       print("Key not found.")
    else:
       print(value)