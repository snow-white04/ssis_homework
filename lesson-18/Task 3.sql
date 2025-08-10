USE msdb;
GO
SELECT m.name AS member_name, r.name AS role_name
FROM sys.database_role_members drm
JOIN sys.database_principals r ON drm.role_principal_id = r.principal_id
JOIN sys.database_principals m ON drm.member_principal_id = m.principal_id
WHERE m.name = 'job_manager';



EXEC msdb.dbo.sp_add_job @job_name = N'TestJob_SA', @enabled = 1, @owner_login_name = N'sa';
EXEC msdb.dbo.sp_add_jobstep
  @job_name = N'TestJob_SA', @step_name = N'Step1',
  @subsystem = N'TSQL', @command = N'SELECT 1;';
EXEC msdb.dbo.sp_add_jobserver @job_name = N'TestJob_SA';



EXEC msdb.dbo.sp_add_job @job_name = N'TestJob_JobManager', @enabled = 1, @owner_login_name = N'job_manager';
EXEC msdb.dbo.sp_add_jobstep
  @job_name = N'TestJob_JobManager', @step_name = N'Step1',
  @subsystem = N'TSQL', @command = N'SELECT 2;';
EXEC msdb.dbo.sp_add_jobserver @job_name = N'TestJob_JobManager';



USE msdb;
EXECUTE AS LOGIN = 'job_manager';



EXEC msdb.dbo.sp_help_job @job_name = N'TestJob_SA';
EXEC msdb.dbo.sp_help_job @job_name = N'TestJob_JobManager';




EXEC msdb.dbo.sp_start_job @job_name = N'TestJob_JobManager';
EXEC msdb.dbo.sp_start_job @job_name = N'TestJob_SA';        