import random
import string
import time
from Crypto.Cipher import AES, DES
from Crypto.Random import get_random_bytes
from Crypto.Util.Padding import pad, unpad
import matplotlib.pyplot as plt

# Cipher Algorithms

# Caesar Cipher
def caesar_cipher_encrypt(plain_text, key):
    encrypted_text = ""
    for char in plain_text:
        if char.isalpha():
            shifted = ord(char) + key
            if char.islower():
                if shifted > ord('z'):
                    shifted -= 26
                elif shifted < ord('a'):
                    shifted += 26
            elif char.isupper():
                if shifted > ord('Z'):
                    shifted -= 26
                elif shifted < ord('A'):
                    shifted += 26
            encrypted_text += chr(shifted)
        else:
            encrypted_text += char
    return encrypted_text

def caesar_cipher_decrypt(encrypted_text, key):
    return caesar_cipher_encrypt(encrypted_text, -key)

# Vigenère Cipher
def vigenere_cipher_encrypt(plain_text, key):
    encrypted_text = ""
    key_length = len(key)
    for i, char in enumerate(plain_text):
        if char.isalpha():
            key_char = key[i % key_length]
            key_shift = ord(key_char.lower()) - ord('a')
            shifted = ord(char) + key_shift
            if char.islower():
                if shifted > ord('z'):
                    shifted -= 26
            elif char.isupper():
                if shifted > ord('Z'):
                    shifted -= 26
            encrypted_text += chr(shifted)
        else:
            encrypted_text += char
    return encrypted_text

def vigenere_cipher_decrypt(encrypted_text, key):
    decrypted_text = ""
    key_length = len(key)
    for i, char in enumerate(encrypted_text):
        if char.isalpha():
            key_char = key[i % key_length]
            key_shift = ord(key_char.lower()) - ord('a')
            shifted = ord(char) - key_shift
            if char.islower():
                if shifted < ord('a'):
                    shifted += 26
            elif char.isupper():
                if shifted < ord('A'):
                    shifted += 26
            decrypted_text += chr(shifted)
        else:
            decrypted_text += char
    return decrypted_text

# Playfair Cipher
def generate_playfair_matrix(key):
    key = key.replace(" ", "").upper()
    key = key.replace("J", "I")  # Replace J with I
    key_set = set(key)
    alphabet = "ABCDEFGHIKLMNOPQRSTUVWXYZ"
    for char in key_set:
        alphabet = alphabet.replace(char, "")
    key += alphabet
    matrix = [key[i:i+5] for i in range(0, 25, 5)]
    return matrix

def find_position(matrix, char):
    for i, row in enumerate(matrix):
        for j, val in enumerate(row):
            if val == char:
                return i, j
    return None

def playfair_cipher_encrypt(plain_text, key):
    plain_text = plain_text.replace(" ", "").upper()
    key_matrix = generate_playfair_matrix(key)
    encrypted_text = ""
    for i in range(0, len(plain_text), 2):
        char1 = plain_text[i]
        char2 = plain_text[i+1] if i+1 < len(plain_text) else 'X'
        row1, col1 = find_position(key_matrix, char1)
        row2, col2 = find_position(key_matrix, char2)
        if row1 == row2:
            encrypted_text += key_matrix[row1][(col1 + 1) % 5]
            encrypted_text += key_matrix[row2][(col2 + 1) % 5]
        elif col1 == col2:
            encrypted_text += key_matrix[(row1 + 1) % 5][col1]
            encrypted_text += key_matrix[(row2 + 1) % 5][col2]
        else:
            encrypted_text += key_matrix[row1][col2]
            encrypted_text += key_matrix[row2][col1]
    return encrypted_text

def playfair_cipher_decrypt(encrypted_text, key):
    key_matrix = generate_playfair_matrix(key)
    decrypted_text = ""
    for i in range(0, len(encrypted_text), 2):
        char1 = encrypted_text[i]
        char2 = encrypted_text[i+1]
        row1, col1 = find_position(key_matrix, char1)
        row2, col2 = find_position(key_matrix, char2)
        if row1 == row2:
            decrypted_text += key_matrix[row1][(col1 - 1) % 5]
            decrypted_text += key_matrix[row2][(col2 - 1) % 5]
        elif col1 == col2:
            decrypted_text += key_matrix[(row1 - 1) % 5][col1]
            decrypted_text += key_matrix[(row2 - 1) % 5][col2]
        else:
            decrypted_text += key_matrix[row1][col2]
            decrypted_text += key_matrix[row2][col1]
    return decrypted_text

# Row Transposition Cipher
def row_transposition_cipher_encrypt(plain_text, key):
    key_order = [int(x) for x in key.split(",")]
    num_columns = len(key_order)
    num_rows = -(-len(plain_text) // num_columns)  # Ceiling division
    matrix = [[' ' for _ in range(num_columns)] for _ in range(num_rows)]
    for i, char in enumerate(plain_text):
        matrix[i // num_columns][i % num_columns] = char
    encrypted_text = ""
    for col in key_order:
        for row in range(num_rows):
            encrypted_text += matrix[row][col - 1]
    return encrypted_text

def row_transposition_cipher_decrypt(encrypted_text, key):
    key_order = [int(x) for x in key.split(",")]
    num_columns = len(key_order)
    num_rows = -(-len(encrypted_text) // num_columns)  # Ceiling division
    matrix = [[' ' for _ in range(num_columns)] for _ in range(num_rows)]
    index = 0
    for col in key_order:
        for row in range(num_rows):
            matrix[row][col - 1] = encrypted_text[index]
            index += 1
    decrypted_text = ""
    for row in range(num_rows):
        for col in range(num_columns):
            decrypted_text += matrix[row][col]
    return decrypted_text

# DES Cipher
def des_encrypt(plain_text, key):
    cipher = DES.new(key, DES.MODE_ECB)
    padded_plain_text = pad(plain_text.encode(), DES.block_size)
    encrypted_text = cipher.encrypt(padded_plain_text)
    return encrypted_text

def des_decrypt(encrypted_text, key):
    cipher = DES.new(key, DES.MODE_ECB)
    decrypted_text = cipher.decrypt(encrypted_text)
    unpadded_decrypted_text = unpad(decrypted_text, DES.block_size)
    return unpadded_decrypted_text.decode()

# AES Cipher
def aes_encrypt(plain_text, key):
    cipher = AES.new(key, AES.MODE_ECB)
    padded_plain_text = pad(plain_text.encode(), AES.block_size)
    encrypted_text = cipher.encrypt(padded_plain_text)
    return encrypted_text

def aes_decrypt(encrypted_text, key):
    cipher = AES.new(key, AES.MODE_ECB)
    decrypted_text = cipher.decrypt(encrypted_text)
    unpadded_decrypted_text = unpad(decrypted_text, AES.block_size)
    return unpadded_decrypted_text.decode()

# Generate random text and keys
def generate_random_text(length):
    return ''.join(random.choice(string.ascii_letters) for _ in range(length))

def generate_random_key(length):
    return ''.join(random.choice(string.ascii_uppercase) for _ in range(length))

random_texts = [generate_random_text(random.randint(1000, 10000)) for _ in range(5)]
random_keys = [generate_random_key(random.randint(8, 16)) for _ in range(5)]

# Measure time consumption for encryption and decryption

# Lists to store time consumption for encryption and decryption
encryption_times = []
decryption_times = []

# Function to measure time taken for encryption and decryption
def measure_time(algorithm, text, key=None):
    start_time = time.time()
    if algorithm == "Caesar":
        caesar_cipher_encrypt(text, 3)
        caesar_cipher_decrypt(text, 3)
    elif algorithm == "Vigenere":
        vigenere_cipher_encrypt(text, "KEY")
        vigenere_cipher_decrypt(text, "KEY")
    elif algorithm == "Playfair":
        playfair_cipher_encrypt(text, "KEYWORD")
        playfair_cipher_decrypt(text, "KEYWORD")
    elif algorithm == "Row Transposition":
        row_transposition_cipher_encrypt(text, "2,1,3")
        row_transposition_cipher_decrypt(text, "2,1,3")
    elif algorithm == "DES":
        key = get_random_bytes(8)
        des_encrypt(text, key)
        des_decrypt(text, key)
    elif algorithm == "AES":
        key = get_random_bytes(16)
        aes_encrypt(text, key)
        aes_decrypt(text, key)
    elapsed_time = time.time() - start_time
    return elapsed_time

# Measure time consumption for each algorithm
algorithms = ["Caesar", "Vigenere", "Playfair", "Row Transposition", "DES", "AES"]
for algorithm in algorithms:
    encryption_time = measure_time(algorithm, random_texts[0])
    decryption_time = measure_time(algorithm, random_texts[0])
    encryption_times.append(encryption_time)
    decryption_times.append(decryption_time)

# Calculate total time for encryption and decryption for each algorithm
total_times = []
for i in range(len(algorithms)):
    total_time = encryption_times[i] + decryption_times[i]
    total_times.append((algorithms[i], total_time))

# Sort algorithms based on total time
sorted_algorithms = sorted(total_times, key=lambda x: x[1])

# Print sorted algorithms
print("Algorithms sorted by total time (encryption + decryption):")
for algorithm, total_time in sorted_algorithms:
    print(f"{algorithm}: {total_time} seconds")
