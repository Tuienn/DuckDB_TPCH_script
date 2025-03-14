import os
import numpy as np
import matplotlib.pyplot as plt
import re

file_path = "runtime_results.txt"
output_image = "runtime_plot.png"

if not os.path.exists(file_path):
    print(f"Error: File '{file_path}' does not exist.")
    exit(1)

real_times, user_times, sys_times = [], [], []
pattern = re.compile(r"real (\d+\.\d+) user (\d+\.\d+) sys (\d+\.\d+)")

with open(file_path, "r") as file:
    for line in file:
        match = pattern.search(line)
        if match:
            real_times.append(float(match.group(1)))
            user_times.append(float(match.group(2)))
            sys_times.append(float(match.group(3)))

if not real_times:
    print("Error: File contains no valid data.")
    exit(1)

mean_real, max_real, min_real = np.mean(real_times), max(real_times), min(real_times)
mean_user, max_user, min_user = np.mean(user_times), max(user_times), min(user_times)
mean_sys, max_sys, min_sys = np.mean(sys_times), max(sys_times), min(sys_times)

print(f"Benchmark Statistics:")
print(f"- Average (s): Real = {mean_real:.4f}, User = {mean_user:.4f}, Sys = {mean_sys:.4f}")
print(f"- Max (s): Real = {max_real:.4f}, User = {max_user:.4f}, Sys = {max_sys:.4f}")
print(f"- Min (s): Real = {min_real:.4f}, User = {min_user:.4f}, Sys = {min_sys:.4f}")

queries = list(range(1, len(real_times) + 1))
plt.figure(figsize=(12, 6))
plt.plot(queries, real_times, "bo-", label="Real Time (s)")
plt.plot(queries, user_times, "gs--", label="User Time (s)")
plt.plot(queries, sys_times, "rd:", label="System Time (s)")

plt.title("Query Execution Time Statistics", fontsize=14, fontweight="bold")
plt.xlabel("Query Index", fontsize=12)
plt.ylabel("Time (s)", fontsize=12)
plt.grid(True, linestyle="--", alpha=0.7)
plt.legend()
plt.savefig(output_image, dpi=300, bbox_inches="tight")

print(f"Plot has been saved at: {output_image}")