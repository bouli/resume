import os
import datetime
coverletters_folder_source = "./.cover-letters"
coverletters_folder_destiny = "./.temp/cover-letters"
coverletters_css_source = "./cover-letter.css"

def main():
    if not os.path.exists(coverletters_folder_source):
        return
    if not os.path.exists(coverletters_folder_destiny):
        os.mkdir(coverletters_folder_destiny)
    coverletters = os.listdir(coverletters_folder_source)
    with open("./cover-letter.md","r") as cl_f:
        coverletter_template = cl_f.read()
    with open("./cover-letter.highlights","r") as cl_f:
        coverletter_highlights = cl_f.read().strip().split("\n")
    with open(coverletters_css_source,"r") as cl_f:
        coverletters_css = cl_f.read()

    for coverletter in coverletters:
        coverletter_final = coverletter_template
        company_name = coverletter.split(".")[0].split("-")[1]
        with open(os.path.join(coverletters_folder_source,coverletter),"r") as cl_f:
            coverletter_content = cl_f.read()
        coverletter_content = coverletter_content.replace("\n","<br>\n")

        coverletter_final = coverletter_final.replace("{cover-letter}",coverletter_content)
        coverletter_final = coverletter_final.replace("{company}",company_name)
        coverletter_final = add_photo(coverletter_final)
        for coverletter_highlight in coverletter_highlights:
            coverletter_final = coverletter_final.replace(f"{coverletter_highlight}",f"__{coverletter_highlight}__")
        date = datetime.datetime.now().strftime("%Y%m%d")
        base_file_name = f"{date}-cover-letter-to-{company_name.replace(" ","-")}"
        with open(os.path.join(coverletters_folder_destiny,f"{base_file_name}.md"),"w+") as cl_f:
            cl_f.write(coverletter_final)
        with open(os.path.join(coverletters_folder_destiny,f"{base_file_name}.css"),"w+") as cl_f:
            cl_f.write(coverletters_css)

def add_photo(file_content):
    return "![Cesar Cardoso](photo.jpeg)\n" + file_content

if __name__=="__main__":
    main()
