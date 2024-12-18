import json


def analyze_livecodebench_error_details(path):
    with open(path, 'r') as f:
        data = json.load(f)
    data = data[1]
    n_complie_error = 0
    n_runtime_error = 0
    n_failed_test = 0
    n_passed_test = 0
    n_bf_passed = 0
    for idx, detail in data.items():
        if -2 in detail[0]:
            n_complie_error += 1
        if '-1' in str(detail[0]):
            n_runtime_error += 1
        if False in detail[0]:
            n_failed_test += 1
        if all([d > 0 for d in detail[0]]):
            n_passed_test += 1

    print(f'Compile Error: {n_complie_error}')
    print(f'Runtime Error: {n_runtime_error}')
    print(f'Failed Test: {n_failed_test}')
    print(f'Passed Test: {n_passed_test}')
    return n_complie_error, n_runtime_error, n_failed_test, n_passed_test

if __name__ == "__main__":
    path = "evaluation-plain/log.json"
    analyze_livecodebench_error_details(path)
