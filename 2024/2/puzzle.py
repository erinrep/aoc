import functools

print("Day 2: Red-Nosed Reports")

with open("input.txt", encoding="utf-8") as f:
    reports = [x.replace("\n", "").split(" ") for x in list(f)]


def is_report_safe(report):
    diffs = []
    for i in range(len(report) - 1):
        diffs.append(int(report[i]) - int(report[i + 1]))
    increasing = all(diff < 0 for diff in diffs)
    decreasing = all(diff > 0 for diff in diffs)
    gentle = all(diff != 0 and abs(diff) <= 3 for diff in diffs)
    return (increasing or decreasing) and gentle


safeReportReducer = lambda acc, report: acc + 1 if is_report_safe(report) else acc
print("Part 1:", functools.reduce(safeReportReducer, reports, 0))

safeReports = 0
for report in reports:
    if is_report_safe(report):
        safeReports += 1
    else:
        for i in range(len(report)):
            temp = report.copy()
            temp.pop(i)
            if is_report_safe(temp):
                safeReports += 1
                break

print("Part 2:", safeReports)
