# youran's command
source ~/Qwen2.5-Coder/.qwenenv/bin/activate

MODEL_DIR=Qwen/Qwen2.5-Coder-7B-Instruct
OUTPUT_DIR=./evaluation-Qwen2.5-Coder-7B-Instruct/
python -m lcb_runner.runner.main --model Qwen/CodeQwen1.5-7B-Chat --model_path ${MODEL_DIR} --output_name "qwen2" --scenario codegeneration --evaluate --output_dir ${OUTPUT_DIR} --n 1 --debug
# --debug               Debug mode
# --n N                 Number of samples to generate, default 10
# Pass@1: 0.3520336605890603
# Easy Pass@1: 0.7184873949579832
# Medium Pass@1: 0.26881720430107525
# Hard Pass@1: 0.025510204081632654

OUTPUT_LOG="${OUTPUT_DIR}/log.json"
python -m lcb_runner.evaluation.compute_scores --eval_all_file ${OUTPUT_LOG}

MODEL_DIR=Qwen/Qwen2.5-Coder-7B-Instruct
OUTPUT_DIR=./evaluation-badcoder/
python -m lcb_runner.runner.main --model MyBadCoder --model_path ${MODEL_DIR} --output_name "badcoder" --scenario codegeneration --evaluate --output_dir ${OUTPUT_DIR} --n 1 --debug
# Pass@1: 0.3338008415147265
# Easy Pass@1: 0.7016806722689075
# Medium Pass@1: 0.24014336917562723
# Hard Pass@1: 0.02040816326530612

MODEL_DIR=Qwen/Qwen2.5-Coder-7B-Instruct
OUTPUT_DIR=./evaluation-bruteforcecoder/
python -m lcb_runner.runner.main --model MyBruteForceCoder --model_path ${MODEL_DIR} --output_name "bruteforcecoder" --scenario codegeneration --evaluate --output_dir ${OUTPUT_DIR} --n 1 --debug



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
