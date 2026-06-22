---
name: SKILL_A_github
description: >
  Guidelines and instructions for using the tools exposed by the github MCP server.
  Automatically loaded when performing tasks related to github.
---

# SKILL_A_github (MCP Tools Guide)

This skill document details the tools, parameters, and guidelines for using the `github` Model Context Protocol (MCP) server within Antigravity.

## Available Tools

### `mcp_github_add_issue_comment` (or call_mcp_tool with ServerName: 'github', ToolName: 'add_issue_comment')
- **Description**: Add a comment to an existing issue
- **Parameters**:
  - `body` (string, Required): 
  - `issue_number` (number, Required): 
  - `owner` (string, Required): 
  - `repo` (string, Required): 

### `mcp_github_create_branch` (or call_mcp_tool with ServerName: 'github', ToolName: 'create_branch')
- **Description**: Create a new branch in a GitHub repository
- **Parameters**:
  - `branch` (string, Required): Name for the new branch
  - `from_branch` (string, Optional): Optional: source branch to create from (defaults to the repository's default branch)
  - `owner` (string, Required): Repository owner (username or organization)
  - `repo` (string, Required): Repository name

### `mcp_github_create_issue` (or call_mcp_tool with ServerName: 'github', ToolName: 'create_issue')
- **Description**: Create a new issue in a GitHub repository
- **Parameters**:
  - `assignees` (array, Optional): 
  - `body` (string, Optional): 
  - `labels` (array, Optional): 
  - `milestone` (number, Optional): 
  - `owner` (string, Required): 
  - `repo` (string, Required): 
  - `title` (string, Required): 

### `mcp_github_create_or_update_file` (or call_mcp_tool with ServerName: 'github', ToolName: 'create_or_update_file')
- **Description**: Create or update a single file in a GitHub repository
- **Parameters**:
  - `branch` (string, Required): Branch to create/update the file in
  - `content` (string, Required): Content of the file
  - `message` (string, Required): Commit message
  - `owner` (string, Required): Repository owner (username or organization)
  - `path` (string, Required): Path where to create/update the file
  - `repo` (string, Required): Repository name
  - `sha` (string, Optional): SHA of the file being replaced (required when updating existing files)

### `mcp_github_create_pull_request` (or call_mcp_tool with ServerName: 'github', ToolName: 'create_pull_request')
- **Description**: Create a new pull request in a GitHub repository
- **Parameters**:
  - `base` (string, Required): The name of the branch you want the changes pulled into
  - `body` (string, Optional): Pull request body/description
  - `draft` (boolean, Optional): Whether to create the pull request as a draft
  - `head` (string, Required): The name of the branch where your changes are implemented
  - `maintainer_can_modify` (boolean, Optional): Whether maintainers can modify the pull request
  - `owner` (string, Required): Repository owner (username or organization)
  - `repo` (string, Required): Repository name
  - `title` (string, Required): Pull request title

### `mcp_github_create_pull_request_review` (or call_mcp_tool with ServerName: 'github', ToolName: 'create_pull_request_review')
- **Description**: Create a review on a pull request
- **Parameters**:
  - `body` (string, Required): The body text of the review
  - `comments` (array, Optional): Comments to post as part of the review (specify either position or line, not both)
  - `commit_id` (string, Optional): The SHA of the commit that needs a review
  - `event` (string, Required): The review action to perform
  - `owner` (string, Required): Repository owner (username or organization)
  - `pull_number` (number, Required): Pull request number
  - `repo` (string, Required): Repository name

### `mcp_github_create_repository` (or call_mcp_tool with ServerName: 'github', ToolName: 'create_repository')
- **Description**: Create a new GitHub repository in your account
- **Parameters**:
  - `autoInit` (boolean, Optional): Initialize with README.md
  - `description` (string, Optional): Repository description
  - `name` (string, Required): Repository name
  - `private` (boolean, Optional): Whether the repository should be private

### `mcp_github_fork_repository` (or call_mcp_tool with ServerName: 'github', ToolName: 'fork_repository')
- **Description**: Fork a GitHub repository to your account or specified organization
- **Parameters**:
  - `organization` (string, Optional): Optional: organization to fork to (defaults to your personal account)
  - `owner` (string, Required): Repository owner (username or organization)
  - `repo` (string, Required): Repository name

### `mcp_github_get_file_contents` (or call_mcp_tool with ServerName: 'github', ToolName: 'get_file_contents')
- **Description**: Get the contents of a file or directory from a GitHub repository
- **Parameters**:
  - `branch` (string, Optional): Branch to get contents from
  - `owner` (string, Required): Repository owner (username or organization)
  - `path` (string, Required): Path to the file or directory
  - `repo` (string, Required): Repository name

### `mcp_github_get_issue` (or call_mcp_tool with ServerName: 'github', ToolName: 'get_issue')
- **Description**: Get details of a specific issue in a GitHub repository.
- **Parameters**:
  - `issue_number` (number, Required): 
  - `owner` (string, Required): 
  - `repo` (string, Required): 

### `mcp_github_get_pull_request` (or call_mcp_tool with ServerName: 'github', ToolName: 'get_pull_request')
- **Description**: Get details of a specific pull request
- **Parameters**:
  - `owner` (string, Required): Repository owner (username or organization)
  - `pull_number` (number, Required): Pull request number
  - `repo` (string, Required): Repository name

### `mcp_github_get_pull_request_comments` (or call_mcp_tool with ServerName: 'github', ToolName: 'get_pull_request_comments')
- **Description**: Get the review comments on a pull request
- **Parameters**:
  - `owner` (string, Required): Repository owner (username or organization)
  - `pull_number` (number, Required): Pull request number
  - `repo` (string, Required): Repository name

### `mcp_github_get_pull_request_files` (or call_mcp_tool with ServerName: 'github', ToolName: 'get_pull_request_files')
- **Description**: Get the list of files changed in a pull request
- **Parameters**:
  - `owner` (string, Required): Repository owner (username or organization)
  - `pull_number` (number, Required): Pull request number
  - `repo` (string, Required): Repository name

### `mcp_github_get_pull_request_reviews` (or call_mcp_tool with ServerName: 'github', ToolName: 'get_pull_request_reviews')
- **Description**: Get the reviews on a pull request
- **Parameters**:
  - `owner` (string, Required): Repository owner (username or organization)
  - `pull_number` (number, Required): Pull request number
  - `repo` (string, Required): Repository name

### `mcp_github_get_pull_request_status` (or call_mcp_tool with ServerName: 'github', ToolName: 'get_pull_request_status')
- **Description**: Get the combined status of all status checks for a pull request
- **Parameters**:
  - `owner` (string, Required): Repository owner (username or organization)
  - `pull_number` (number, Required): Pull request number
  - `repo` (string, Required): Repository name

### `mcp_github_list_commits` (or call_mcp_tool with ServerName: 'github', ToolName: 'list_commits')
- **Description**: Get list of commits of a branch in a GitHub repository
- **Parameters**:
  - `owner` (string, Required): 
  - `page` (number, Optional): 
  - `perPage` (number, Optional): 
  - `repo` (string, Required): 
  - `sha` (string, Optional): 

### `mcp_github_list_issues` (or call_mcp_tool with ServerName: 'github', ToolName: 'list_issues')
- **Description**: List issues in a GitHub repository with filtering options
- **Parameters**:
  - `direction` (string, Optional): 
  - `labels` (array, Optional): 
  - `owner` (string, Required): 
  - `page` (number, Optional): 
  - `per_page` (number, Optional): 
  - `repo` (string, Required): 
  - `since` (string, Optional): 
  - `sort` (string, Optional): 
  - `state` (string, Optional): 

### `mcp_github_list_pull_requests` (or call_mcp_tool with ServerName: 'github', ToolName: 'list_pull_requests')
- **Description**: List and filter repository pull requests
- **Parameters**:
  - `base` (string, Optional): Filter by base branch name
  - `direction` (string, Optional): The direction of the sort
  - `head` (string, Optional): Filter by head user or head organization and branch name
  - `owner` (string, Required): Repository owner (username or organization)
  - `page` (number, Optional): Page number of the results
  - `per_page` (number, Optional): Results per page (max 100)
  - `repo` (string, Required): Repository name
  - `sort` (string, Optional): What to sort results by
  - `state` (string, Optional): State of the pull requests to return

### `mcp_github_merge_pull_request` (or call_mcp_tool with ServerName: 'github', ToolName: 'merge_pull_request')
- **Description**: Merge a pull request
- **Parameters**:
  - `commit_message` (string, Optional): Extra detail to append to automatic commit message
  - `commit_title` (string, Optional): Title for the automatic commit message
  - `merge_method` (string, Optional): Merge method to use
  - `owner` (string, Required): Repository owner (username or organization)
  - `pull_number` (number, Required): Pull request number
  - `repo` (string, Required): Repository name

### `mcp_github_push_files` (or call_mcp_tool with ServerName: 'github', ToolName: 'push_files')
- **Description**: Push multiple files to a GitHub repository in a single commit
- **Parameters**:
  - `branch` (string, Required): Branch to push to (e.g., 'main' or 'master')
  - `files` (array, Required): Array of files to push
  - `message` (string, Required): Commit message
  - `owner` (string, Required): Repository owner (username or organization)
  - `repo` (string, Required): Repository name

### `mcp_github_search_code` (or call_mcp_tool with ServerName: 'github', ToolName: 'search_code')
- **Description**: Search for code across GitHub repositories
- **Parameters**:
  - `order` (string, Optional): 
  - `page` (number, Optional): 
  - `per_page` (number, Optional): 
  - `q` (string, Required): 

### `mcp_github_search_issues` (or call_mcp_tool with ServerName: 'github', ToolName: 'search_issues')
- **Description**: Search for issues and pull requests across GitHub repositories
- **Parameters**:
  - `order` (string, Optional): 
  - `page` (number, Optional): 
  - `per_page` (number, Optional): 
  - `q` (string, Required): 
  - `sort` (string, Optional): 

### `mcp_github_search_repositories` (or call_mcp_tool with ServerName: 'github', ToolName: 'search_repositories')
- **Description**: Search for GitHub repositories
- **Parameters**:
  - `page` (number, Optional): Page number for pagination (default: 1)
  - `perPage` (number, Optional): Number of results per page (default: 30, max: 100)
  - `query` (string, Required): Search query (see GitHub search syntax)

### `mcp_github_search_users` (or call_mcp_tool with ServerName: 'github', ToolName: 'search_users')
- **Description**: Search for users on GitHub
- **Parameters**:
  - `order` (string, Optional): 
  - `page` (number, Optional): 
  - `per_page` (number, Optional): 
  - `q` (string, Required): 
  - `sort` (string, Optional): 

### `mcp_github_update_issue` (or call_mcp_tool with ServerName: 'github', ToolName: 'update_issue')
- **Description**: Update an existing issue in a GitHub repository
- **Parameters**:
  - `assignees` (array, Optional): 
  - `body` (string, Optional): 
  - `issue_number` (number, Required): 
  - `labels` (array, Optional): 
  - `milestone` (number, Optional): 
  - `owner` (string, Required): 
  - `repo` (string, Required): 
  - `state` (string, Optional): 
  - `title` (string, Optional): 

### `mcp_github_update_pull_request_branch` (or call_mcp_tool with ServerName: 'github', ToolName: 'update_pull_request_branch')
- **Description**: Update a pull request branch with the latest changes from the base branch
- **Parameters**:
  - `expected_head_sha` (string, Optional): The expected SHA of the pull request's HEAD ref
  - `owner` (string, Required): Repository owner (username or organization)
  - `pull_number` (number, Required): Pull request number
  - `repo` (string, Required): Repository name

## Best Practices & Guidelines

1. **Verify Parameters**: Double-check parameter names and types before invoking any tool. Missing required properties will cause errors.
2. **Minimize Output Bloat**: If a tool returns a large volume of data (e.g., file contents, search results), do NOT dump the entire payload to stdout. Instead, save the output to the scratch directory (`C:\Users\user\.gemini\antigravity\scratch`) and present only the summary to the user.
3. **Error Resilience**: If a tool call fails, log the error details, self-correct the parameters, and retry up to 3 times before reporting the error to the user.
4. **Security & Governance**: Respect all safety guidelines. Do not perform destructive actions (like deleting branches or repositories) without explicit user approval.
5. **User-Facing Artifacts in Korean**: When presenting artifacts, walkthroughs, or reports derived from these tools to the user, write them in Korean as per user policy.
