import urllib.request
import re
import sys
import numpy
import matplotlib.pyplot as plt


def findAllPageUrl(auth) :
    # get html string
    url = "https://arxiv.org/search/?query=%s&searchtype=author" % (auth)
    content = urllib.request.urlopen(url)
    html_str = content.read().decode("utf-8")
    
    #get url for every page
    pattern = "pagination-list[\s\S]*?</ul>"
    pagelist_str = re.search(pattern, html_str).group(0)
    pattern = "<a href=\"[\s\S]*?</a>"
    pages_str = re.findall(pattern, pagelist_str)
    pages = list(())
    for p in pages_str :
        s = p.split("<a href=\"")[1].split("\"")[0].strip().replace("&amp;", "&")
        pages.append(s)
    return pages


if __name__ == "__main__":
    host = "https://arxiv.org"
    auth = sys.argv[1]
    auth_sr = auth.replace("+", " ")
    print("Input Author: %s" % auth_sr)
    pagesUrl = findAllPageUrl(auth)

    #get announced times list & co-author list
    times = list(())
    coauth = list(())
    for page in pagesUrl:
        url = "%s%s" % (host, page)

        content = urllib.request.urlopen(url)
        html_str = content.read().decode("utf-8")

        #find originally announced time
        pattern = "originally announced</span>[\s\S]*?</p>"
        times_str = re.findall(pattern, html_str)
        for t_str in times_str:
            times.append(t_str.split("</span>")[1].split("</p>")[0].strip().split(" ")[1].strip("."))

        #find every co-author
        pattern = "Authors:</span>[\s\S]*?</p>"
        coauth_str = re.findall(pattern, html_str)
        for cos in coauth_str:
            pattern = "<a href=[\s\S]*?</a>"
            coa_lines = re.findall(pattern, cos)
            for line in coa_lines:
                coauth.append(line.split("\">")[1].split("</a>")[0])

    #count every element in times
    times.sort()
    x = list(())
    y = list(())
    i = -1
    cur = ""
    for t in times:
        if cur != t:
            cur = t
            x.append(t)
            y.append(1)
            i += 1
        else:
            y[i] += 1

    plt.bar(x, y)
    plt.savefig("./output.jpg")

    x.clear()
    y.clear()

    #count every author in coauthor
    coauth.sort()
    i = -1
    cur = ""
    for a in coauth:
        if a == auth_sr:
            continue
        if cur != a:
            cur = a
            x.append(a)
            y.append(1)
            i += 1
        else:
            y[i] += 1
    
    i = 0
    for name in x:
        print("%s: %d times" % (name, y[i]))
        i += 1
