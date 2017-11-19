# Symmetric Decryption of Message With AES 192 CBC Algorithm And K1.bin Key
openssl enc -aes-192-cbc -in ./message.txt.enc -d -out ./message.txt -kfile k1.bin

# Generate Symmetric Key K2.bin
openssl rand -base64 -out k2.bin 128

# Encrypt K2.bin Using alice_pub.pem key With RSA
openssl rsautl -encrypt -inkey alice_pub.pem -pubin -in k2.bin -out k2.bin.enc

# Encrypt Completed Message With K2.bin And DES ECB Algorithm
openssl enc -des-ecb -e -in new_message.txt -out new_message.txt.enc -kfile k2.bin

# Generate Private Key (4096 bit)
openssl genrsa -out private.pem 4096

# Digital Signing new_message.txt With SHA512 and my private key
openssl dgst -sha512 -sign private.pem -out new_message.txt.sign.sha512 new_message.txt

# Extract Public Key From Private Key
openssl rsa -in private.pem -out public.pem -outform PEM -pubout

