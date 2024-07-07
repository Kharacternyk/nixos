from hashlib import sha256


def display(red, green, blue):
    return f"\033[48;2;{red};{green};{blue}m\007    \033(B\033[m"


try:
    while True:
        string = input()
        if not string:
            continue

        digest = sha256(string.encode()).digest()
        print(f"{display(*digest[:3])}{display(*digest[-3:])}")
except EOFError:
    pass
