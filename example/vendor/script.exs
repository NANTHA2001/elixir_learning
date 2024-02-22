
todo_list = JobUpdater.process_job_updates("v1_jobs_1h.csv")
IO.inspect(JobUpdater.process_job_updates("v1_jobs_1h.csv"))
JobUpdater.process_job_updates("v1_jobs_1h.csv", "latency_output.txt")
