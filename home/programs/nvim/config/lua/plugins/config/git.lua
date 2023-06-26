local git_status, git = pcall(require, "fugitive")
if not git_status then
	return
end

git.setup()
