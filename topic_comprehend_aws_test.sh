




#grab some medlines based on query to pubmed
esearch -db pubmed --query 'maize nitrate' | efetch --format medline > maize_nitrate.abstracts
esearch -db pubmed --query 'soybean drought' | efetch --format medline > soybean_drought.abstracts
esearch -db pubmed --query 'rice cold' | efetch --format medline > rice_cold.abstracts

#split them all into individual files
awk -v RS= '{print > ("0abstract-" NR ".txt"); close(("0abstract-" NR ".txt"))}' maize_nitrate.abstracts
awk -v RS= '{print > ("1abstract-" NR ".txt"); close(("1abstract-" NR ".txt"))}' soybean_drought.abstracts
awk -v RS= '{print > ("2abstract-" NR ".txt"); close(("2abstract-" NR ".txt"))}' rice_cold.abstracts

for FILE in *.txt; do sed -n '/^AB/,/^CI/p' $FILE | grep -v "^CI" | sed 's/^AB  - //g' > ${FILE}.parsed; done

 #make and s3 bucket for them
 aws s3api create-bucket --bucket test-comprehend-abstracts --region us-east-1


 #copy em over
 aws s3 cp . s3://test-comprehend-abstracts --recursive --exclude "*.txt"
