source ~/Qwen2.5-Coder/.qwenenv/bin/activate

MODEL_DIR=Qwen/Qwen2.5-Coder-7B-Instruct
OUTPUT_DIR=./evaluation-plain
python -m lcb_runner.runner.main --model Qwen/CodeQwen1.5-7B-Chat --model_path ${MODEL_DIR} --output_name "qwen2" --scenario codegeneration --evaluate --output_dir ${OUTPUT_DIR} --n 2 --debug

echo "finished ${OUTPUT_DIR}" >> log.txt
OUTPUT_LOG="${OUTPUT_DIR}/log.json"
python -m lcb_runner.evaluation.compute_scores --eval_all_file ${OUTPUT_LOG} >> log.txt

OUTPUT_DIR=./evaluation-badcoder/
python -m lcb_runner.runner.main --model MyBadCoder --model_path ${MODEL_DIR} --output_name "badcoder" --scenario codegeneration --evaluate --output_dir ${OUTPUT_DIR} --n 2 --debug

echo "finished ${OUTPUT_DIR}" >> log.txt
OUTPUT_LOG="${OUTPUT_DIR}/log.json"
python -m lcb_runner.evaluation.compute_scores --eval_all_file ${OUTPUT_LOG} >> log.txt

OUTPUT_DIR=./evaluation-bruteforcecoder
python -m lcb_runner.runner.main --model MyBruteforceCoder --model_path ${MODEL_DIR} --output_name "bruteforcecoder" --scenario codegeneration --evaluate --output_dir ${OUTPUT_DIR} --n 2 --debug

echo "finished ${OUTPUT_DIR}" >> log.txt
OUTPUT_LOG="${OUTPUT_DIR}/log.json"
python -m lcb_runner.evaluation.compute_scores --eval_all_file ${OUTPUT_LOG} >> log.txt