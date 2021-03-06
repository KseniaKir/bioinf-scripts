# This script runs fastqc on all fastq files in given folder
# 1st argument - path with input fastq files
# 2nd argument - folder in which output should be written
# 3nd argument - number of threads
# Example: path_to_this_script.bash /folder/with/fastq/files /output/folder 8

IN_PATH=$1
OUT_PATH=$2
N_THREADS=$3

# Create output folder if not already created
mkdir -p ${OUT_PATH}

# Iterate through all fastq files in IN_PATH and run fastqc
for filename in ${IN_PATH}/*.fastq; do
	echo "Started fastqc for ${filename}"
	fastqc ${filename} -o ${OUT_PATH} -t ${N_THREADS}
	echo "Finished fastqc for ${filename}"
done

# Now create one summary file for all samples
echo "Generating summary file for all samples"
unzip ${OUT_PATH}/\*.zip -d ${OUT_PATH}
cat ${OUT_PATH}/*_fastqc/summary.txt > ${OUT_PATH}/summary.txt
