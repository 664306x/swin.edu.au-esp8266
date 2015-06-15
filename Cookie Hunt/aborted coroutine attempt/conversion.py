#!/usr/bin/env/python3

import argparse, mimetypes, hashlib, gzip, os

parser = argparse.ArgumentParser(description='Ready files and filelist for transfer to the esp8266 web server')
parser.add_argument('files', type=str, nargs='+', help='files to be compressed and uploaded')

args = parser.parse_args()
files = args.files

files_start = "local module = {}\n" + "local function add_file (filename, file_etag, mime_type, filesize_bytes)\n" + "\tlocal file = {}\n" + "\tmodule[filename] = file\n" + "\tmodule[filename][1] = file_etag\n" + "\tmodule[filename][2] = mime_type\n" + "\tmodule[filename][3] = filesize_bytes\n" + "end\n"
files_end = "add_file = nil\n" + "return module"

f = open('files.lua', 'w')
f.write(files_start)
for file in files:
    type, _ = mimetypes.guess_type(file, strict=True)
    newname = hashlib.md5(file.encode('utf-8')).hexdigest()
    with open(file, 'rb') as f_in:
        with gzip.open(newname, 'wb') as f_out:
            f_out.writelines(f_in)
    function_call = "add_file('" + file + "', '" + newname + "', '" + type + "', '" + str(os.path.getsize(newname)) + "')\n"
    f.write(function_call)
f.write(files_end)