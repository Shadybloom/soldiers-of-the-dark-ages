#!/bin/sh

md_dir=$1
#html_dir=$2
html_dir="$md_dir/html/"
mkdir $html_dir

ls -p $md_dir | grep -v / | while read filename
    do
        file_md="$md_dir/$filename"
        chapter_name=`cat $file_md | egrep '^# ' | sed 's/# //g'`
        file_html="$html_dir$filename.html"
        echo $md_dir$file_html
        echo '<html><head><META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8"></head><body>' > $file_html
        cat $file_md | \
            # Эпиграфы, иллюстрации:
            sed "s|^## \(.*\)|<span align="center"><h4><em>\1</em></h4></span>|g" | \
            # Метки времени, границы сцен:
            sed "s|^### \(.*\)|<span align="center"><h5><em>\1</em></h5></span>|g" | \
            # Иллюстрации, карты:
            sed "s|\!\[\(.*\)\](\(.*\))|<img src=\"https://raw.githubusercontent.com/Shadybloom/soldiers-of-the-dark-ages/master\2\" alt=\"\1\">|g" | \
            # Ссылки:
            sed "s|\[\(.*\)\](\(.*\))|<a href=\"https://github.com/Shadybloom/soldiers-of-the-dark-ages/blob/master\2\">\1</a>|g" | \
            # Курсив:
            sed "s;^_\(.*\)\_  $;<em>\1</em>;g" | \
            # Жирный шрифт:
            sed "s;^\*\*\(.*\)\*\*$;<b>\1</b>;g" | \
            # Символы новой строки:
            sed "s|$|<br>|" >> $file_html
        echo '</body></html>' >> $file_html
    done



# Скрипт должен создавать кучу файлов с названиями глав.
# И переносить в них текст, превращая формат md в hrml.
    # При этом ссылки на картинки дожны стать полными.


# Эпиграфы, иллюстрации:
#sed "s|^## \(.*\)|<span align="center">\*\*\*<em> \1 </em>\*\*\*</span>|g"
# Метки времени, границы сцен:
#sed "s|^### \(.*\)|<span align="center">\*\*\*<em> \1 </em>\*\*\*</span>|g"
# Иллюстрации, карты:
#sed "s|\!\[\(.*\)\](\(.*\))|<img src=\"https://raw.githubusercontent.com/Shadybloom/soldiers-of-the-dark-ages/master\2\" alt=\"\1\">|g"
# Ссылки:
#sed "s|\[\(.*\)\](\(.*\))|<a href=\"https://github.com/Shadybloom/soldiers-of-the-dark-ages/blob/master\2\">\1</a>|g"
# Символы новой строки:
#sed "s|  $|<br>|g"
# Курсив:
#sed "s;^_\(.*\)\_$;<em>\1</em>;g"
# Жирный шрифт:
#sed "s;^\*\*\(.*\)\*\*$;<b>\1</b>;g"


# Курсив (удаляем из текста):
# sed "s;\(^_\|_$\|_  $\);;g"
