# youran's command
source ~/Qwen2.5-Coder/.qwenenv/bin/activate

MODEL_DIR=Qwen/Qwen2.5-Coder-7B-Instruct
OUTPUT_DIR=./evaluation-plain
python -m lcb_runner.runner.main --model Qwen/CodeQwen1.5-7B-Chat --model_path ${MODEL_DIR} --output_name "qwen2" --scenario codegeneration --evaluate --output_dir ${OUTPUT_DIR} --n 2 --debug

OUTPUT_LOG="${OUTPUT_DIR}/log.json"
python -m lcb_runner.evaluation.compute_scores --eval_all_file ${OUTPUT_LOG}

OUTPUT_DIR=./evaluation-badcoder/
python -m lcb_runner.runner.main --model MyBadCoder --model_path ${MODEL_DIR} --output_name "badcoder" --scenario codegeneration --evaluate --output_dir ${OUTPUT_DIR} --n 2 --debug

OUTPUT_DIR=./evaluation-bruteforcecoder
python -m lcb_runner.runner.main --model MyBruteforceCoder --model_path ${MODEL_DIR} --output_name "bruteforcecoder" --scenario codegeneration --evaluate --output_dir ${OUTPUT_DIR} --n 2 --debug

# totally 713 problems, sigma approx sqrt(0.3*0.7/713) = 0.015
# Qwen7B n=1
# plain 0.352
# badcoder 0.334
# bruteforcecoder 只改 system 提示词 0.323


export HF_ENDPOINT=https://hf-mirror.com
export PATH=./envs/vllm_python310/bin:$PATH

MODEL_DIR=${1}
MODEL_DIR=${MODEL_DIR:-"/path/to/model"}
TP=${2}
TP=${TP:-TP}
OUTPUT_DIR=${3}
OUTPUT_DIR=${OUTPUT_DIR:-"./evaluation/livecode_bench"}
echo "LiveCodeBench: ${MODEL_DIR}, OUPTUT_DIR: ${OUTPUT_DIR}"


python -m lcb_runner.runner.main --model Qwen/CodeQwen1.5-7B-Chat --model_path ${MODEL_DIR} --output_name "qwen2" --scenario codegeneration --evaluate --tensor_parallel_size ${TP} --output_dir ${OUTPUT_DIR}
saved_eval_all_file="${OUTPUT_DIR}/log.json"
python -m lcb_runner.evaluation.compute_scores --eval_all_file ${saved_eval_all_file} --start_date 2024-05-01
