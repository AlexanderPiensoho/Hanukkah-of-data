#!/usr/bin/env python3

import sqlite3

t9_mapping = {
    "2": "abc", 
    "3": "def",
    "4": "ghi",
    "5": "jkl",
    "6": "mno",
    "7": "pqrs",
    "8": "tuv",
    "9": "wxyz"
}

def t_nine_dict(name):
    t9_number = ""
    for char in name.lower():
        for key, value in t9_mapping.items():
            if char in value:
                t9_number += key
    return t9_number


if __name__ == "__main__":
    con = sqlite3.connect("../5784/noahs.sqlite")
    cur = con.cursor() 

    phone_name = cur.execute("""SELECT SUBSTR(name, INSTR(name, ' ') +1 ) AS last_name,
                            REPLACE(phone, '-', '') AS norm_phone
                            FROM customers;""")
    
    for name, phone in phone_name:
        t9 = t_nine_dict(name)
        if t9 == phone:
            print(t9)
