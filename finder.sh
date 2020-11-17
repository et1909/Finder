#!/bin/bash -x 
search(){

read web

while read -r file;
do
  # echo "$file"
  sour=$(curl "$file")
  write=$(echo "$sour" | cat >> write_file )
  grep -o 'https://[^"]*' write_file.txt >> domains
done < "$web"

input="domains"
read -p "STATUS CODE : " status_code
read -p "OUPUT FILE NAME : " output_file_name
list_of_200=('200 201 202 203 204 205 206 207 208 226');
list_of_300=('300 301 302 303 304 305 306 307 308');
list_of_400=('400 401 402 403 404 405 406 407 408 409 410 411 412 413 414 415 416 417 418 421 422 423 424 425 426 428 429 431 451');
list_of_500=('500 501 502 503 504 505 506 507 508 510 511');

while IFS= read -r line
do
  STATUS=$(curl -s -o /dev/null -I -w "%{http_code}" "$line")
  echo "$line" >> response_code
  echo "$STATUS" >> response_code

  if [ "$STATUS" == "$status_code" ]
  then
    echo "$line" >> $output_file_name
    echo "$STATUS" >> $output_file_name
    
  elif [ $status_code == "200s" ]
  then 

    for a in $list_of_200
    do
      if [ $STATUS == $a ]
      then
        echo "$line" >> $output_file_name
        echo "$STATUS" >> $output_file_name
      fi
    done

  elif [ "$STATUS" == "$status_code" ]
  then
    echo "$line" >> $output_file_name
    echo "$STATUS" >> $output_file_name
    
  
  elif [ $status_code == "300s" ]
  then 

    for b in $list_of_300
    do
      if [ $STATUS == $b ]
      then
        echo "$line" >> $output_file_name
        echo "$STATUS" >> $output_file_name
      fi
    done

  elif [ "$STATUS" == "$status_code" ]
  then
    echo "$STATUS" >> $output_file_name
    echo "">> $output_file_name
  
  elif [ $status_code == "400s" ]
  then

    for c in $list_of_400
    do
      if [ $STATUS == $c ]
      then
        echo "$line" >> $output_file_name
        echo "$STATUS" >> $output_file_name
      fi
    done
  

  elif [ "$STATUS" == "$status_code" ]
  then
    echo "$STATUS" >> $output_file_name
    echo "">> $output_file_name
  
  elif [ $status_code == "500s" ]
  then 

    for d in $list_of_500
    do
      if [ $STATUS == $c ]
      then
        echo "$line" >> $output_file_name
        echo "$STATUS" >> $output_file_name
      fi
    done
  fi

  # echo "" >> response_code.txt
done < "$input"

}

search

