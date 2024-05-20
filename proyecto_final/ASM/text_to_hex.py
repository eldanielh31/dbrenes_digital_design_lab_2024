def text_to_hex(input_file, output_file):
    with open(input_file, 'r', encoding='utf-8') as f:
        text = f.read()
    
    hex_text = text.encode('utf-8').hex()
    
    with open(output_file, 'w') as f:
        f.write(hex_text)

if __name__ == "__main__":
    input_file = "input_text.txt"
    output_file = "output_text.hex"
    text_to_hex(input_file, output_file)
    print(f"Archivo hexadecimal guardado en {output_file}")
    