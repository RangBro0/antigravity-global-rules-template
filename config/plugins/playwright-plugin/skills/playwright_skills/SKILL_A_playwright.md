---
name: SKILL_A_playwright
description: >
  Guidelines and instructions for using the tools exposed by the playwright MCP server.
  Automatically loaded when performing tasks related to playwright.
---

# SKILL_A_playwright (MCP Tools Guide)

This skill document details the tools, parameters, and guidelines for using the `playwright` Model Context Protocol (MCP) server within Antigravity.

## Available Tools

### `mcp_playwright_browser_click` (or call_mcp_tool with ServerName: 'playwright', ToolName: 'browser_click')
- **Description**: Perform click on a web page
- **Parameters**:
  - `button` (string, Optional): Button to click, defaults to left
  - `doubleClick` (boolean, Optional): Whether to perform a double click instead of a single click
  - `element` (string, Optional): Human-readable element description used to obtain permission to interact with the element
  - `modifiers` (array, Optional): Modifier keys to press
  - `target` (string, Required): Exact target element reference from the page snapshot, or a unique element selector

### `mcp_playwright_browser_close` (or call_mcp_tool with ServerName: 'playwright', ToolName: 'browser_close')
- **Description**: Close the page
- **Parameters**: None

### `mcp_playwright_browser_console_messages` (or call_mcp_tool with ServerName: 'playwright', ToolName: 'browser_console_messages')
- **Description**: Returns all console messages
- **Parameters**:
  - `all` (boolean, Optional): Return all console messages since the beginning of the session, not just since the last navigation. Defaults to false.
  - `filename` (string, Optional): Filename to save the console messages to. If not provided, messages are returned as text.
  - `level` (string, Required): Level of the console messages to return. Each level includes the messages of more severe levels. Defaults to "info".

### `mcp_playwright_browser_drag` (or call_mcp_tool with ServerName: 'playwright', ToolName: 'browser_drag')
- **Description**: Perform drag and drop between two elements
- **Parameters**:
  - `endElement` (string, Optional): Human-readable target element description used to obtain the permission to interact with the element
  - `endTarget` (string, Required): Exact target element reference from the page snapshot, or a unique element selector
  - `startElement` (string, Optional): Human-readable source element description used to obtain the permission to interact with the element
  - `startTarget` (string, Required): Exact target element reference from the page snapshot, or a unique element selector

### `mcp_playwright_browser_drop` (or call_mcp_tool with ServerName: 'playwright', ToolName: 'browser_drop')
- **Description**: Drop files or MIME-typed data onto an element, as if dragged from outside the page. At least one of "paths" or "data" must be provided.
- **Parameters**:
  - `data` (object, Optional): Data to drop, as a map of MIME type to string value (e.g. {"text/plain": "hello", "text/uri-list": "https://example.com"}).
  - `element` (string, Optional): Human-readable element description used to obtain permission to interact with the element
  - `paths` (array, Optional): Absolute paths to files to drop onto the element.
  - `target` (string, Required): Exact target element reference from the page snapshot, or a unique element selector

### `mcp_playwright_browser_evaluate` (or call_mcp_tool with ServerName: 'playwright', ToolName: 'browser_evaluate')
- **Description**: Evaluate JavaScript expression on page or element
- **Parameters**:
  - `element` (string, Optional): Human-readable element description used to obtain permission to interact with the element
  - `filename` (string, Optional): Filename to save the result to. If not provided, result is returned as text.
  - `function` (string, Required): () => { /* code */ } or (element) => { /* code */ } when element is provided
  - `target` (string, Optional): Exact target element reference from the page snapshot, or a unique element selector

### `mcp_playwright_browser_file_upload` (or call_mcp_tool with ServerName: 'playwright', ToolName: 'browser_file_upload')
- **Description**: Upload one or multiple files
- **Parameters**:
  - `paths` (array, Optional): The absolute paths to the files to upload. Can be single file or multiple files. If omitted, file chooser is cancelled.

### `mcp_playwright_browser_fill_form` (or call_mcp_tool with ServerName: 'playwright', ToolName: 'browser_fill_form')
- **Description**: Fill multiple form fields
- **Parameters**:
  - `fields` (array, Required): Fields to fill in

### `mcp_playwright_browser_handle_dialog` (or call_mcp_tool with ServerName: 'playwright', ToolName: 'browser_handle_dialog')
- **Description**: Handle a dialog
- **Parameters**:
  - `accept` (boolean, Required): Whether to accept the dialog.
  - `promptText` (string, Optional): The text of the prompt in case of a prompt dialog.

### `mcp_playwright_browser_hover` (or call_mcp_tool with ServerName: 'playwright', ToolName: 'browser_hover')
- **Description**: Hover over element on page
- **Parameters**:
  - `element` (string, Optional): Human-readable element description used to obtain permission to interact with the element
  - `target` (string, Required): Exact target element reference from the page snapshot, or a unique element selector

### `mcp_playwright_browser_navigate` (or call_mcp_tool with ServerName: 'playwright', ToolName: 'browser_navigate')
- **Description**: Navigate to a URL
- **Parameters**:
  - `url` (string, Required): The URL to navigate to

### `mcp_playwright_browser_navigate_back` (or call_mcp_tool with ServerName: 'playwright', ToolName: 'browser_navigate_back')
- **Description**: Go back to the previous page in the history
- **Parameters**: None

### `mcp_playwright_browser_network_request` (or call_mcp_tool with ServerName: 'playwright', ToolName: 'browser_network_request')
- **Description**: Returns full details (headers and body) of a single network request, or a single part if `part` is set. Use the number from browser_network_requests.
- **Parameters**:
  - `filename` (string, Optional): Filename to save the result to. If not provided, output is returned as text.
  - `index` (integer, Required): 1-based index of the request, as printed by browser_network_requests.
  - `part` (string, Optional): Return only this part of the request. Omit to return full details.

### `mcp_playwright_browser_network_requests` (or call_mcp_tool with ServerName: 'playwright', ToolName: 'browser_network_requests')
- **Description**: Returns a numbered list of network requests since loading the page. Use browser_network_request with the number to get full details.
- **Parameters**:
  - `filename` (string, Optional): Filename to save the network requests to. If not provided, requests are returned as text.
  - `filter` (string, Optional): Only return requests whose URL matches this regexp (e.g. "/api/.*user").
  - `static` (boolean, Required): Whether to include successful static resources like images, fonts, scripts, etc. Defaults to false.

### `mcp_playwright_browser_press_key` (or call_mcp_tool with ServerName: 'playwright', ToolName: 'browser_press_key')
- **Description**: Press a key on the keyboard
- **Parameters**:
  - `key` (string, Required): Name of the key to press or a character to generate, such as `ArrowLeft` or `a`

### `mcp_playwright_browser_resize` (or call_mcp_tool with ServerName: 'playwright', ToolName: 'browser_resize')
- **Description**: Resize the browser window
- **Parameters**:
  - `height` (number, Required): Height of the browser window
  - `width` (number, Required): Width of the browser window

### `mcp_playwright_browser_run_code_unsafe` (or call_mcp_tool with ServerName: 'playwright', ToolName: 'browser_run_code_unsafe')
- **Description**: Run a Playwright code snippet. Unsafe: executes arbitrary JavaScript in the Playwright server process and is RCE-equivalent.
- **Parameters**:
  - `code` (string, Optional): A JavaScript function containing Playwright code to execute. It will be invoked with a single argument, page, which you can use for any page interaction. For example: `async (page) => { await page.getByRole('button', { name: 'Submit' }).click(); return await page.title(); }`
  - `filename` (string, Optional): Load code from the specified file. If both code and filename are provided, code will be ignored.

### `mcp_playwright_browser_select_option` (or call_mcp_tool with ServerName: 'playwright', ToolName: 'browser_select_option')
- **Description**: Select an option in a dropdown
- **Parameters**:
  - `element` (string, Optional): Human-readable element description used to obtain permission to interact with the element
  - `target` (string, Required): Exact target element reference from the page snapshot, or a unique element selector
  - `values` (array, Required): Array of values to select in the dropdown. This can be a single value or multiple values.

### `mcp_playwright_browser_snapshot` (or call_mcp_tool with ServerName: 'playwright', ToolName: 'browser_snapshot')
- **Description**: Capture accessibility snapshot of the current page, this is better than screenshot
- **Parameters**:
  - `boxes` (boolean, Optional): Include each element's bounding box as [box=x,y,width,height] in the snapshot. Coordinates are viewport-relative, in CSS pixels (Element.getBoundingClientRect)
  - `depth` (number, Optional): Limit the depth of the snapshot tree
  - `filename` (string, Optional): Save snapshot to markdown file instead of returning it in the response.
  - `target` (string, Optional): Exact target element reference from the page snapshot, or a unique element selector

### `mcp_playwright_browser_tabs` (or call_mcp_tool with ServerName: 'playwright', ToolName: 'browser_tabs')
- **Description**: List, create, close, or select a browser tab.
- **Parameters**:
  - `action` (string, Required): Operation to perform
  - `index` (number, Optional): Tab index, used for close/select. If omitted for close, current tab is closed.
  - `url` (string, Optional): URL to navigate to in the new tab, used for new.

### `mcp_playwright_browser_take_screenshot` (or call_mcp_tool with ServerName: 'playwright', ToolName: 'browser_take_screenshot')
- **Description**: Take a screenshot of the current page. You can't perform actions based on the screenshot, use browser_snapshot for actions.
- **Parameters**:
  - `element` (string, Optional): Human-readable element description used to obtain permission to interact with the element
  - `filename` (string, Optional): File name to save the screenshot to. Defaults to `page-{timestamp}.{png|jpeg}` if not specified. Prefer relative file names to stay within the output directory.
  - `fullPage` (boolean, Optional): When true, takes a screenshot of the full scrollable page, instead of the currently visible viewport. Cannot be used with element screenshots.
  - `target` (string, Optional): Exact target element reference from the page snapshot, or a unique element selector
  - `type` (string, Required): Image format for the screenshot. Default is png.

### `mcp_playwright_browser_type` (or call_mcp_tool with ServerName: 'playwright', ToolName: 'browser_type')
- **Description**: Type text into editable element
- **Parameters**:
  - `element` (string, Optional): Human-readable element description used to obtain permission to interact with the element
  - `slowly` (boolean, Optional): Whether to type one character at a time. Useful for triggering key handlers in the page. By default entire text is filled in at once.
  - `submit` (boolean, Optional): Whether to submit entered text (press Enter after)
  - `target` (string, Required): Exact target element reference from the page snapshot, or a unique element selector
  - `text` (string, Required): Text to type into the element

### `mcp_playwright_browser_wait_for` (or call_mcp_tool with ServerName: 'playwright', ToolName: 'browser_wait_for')
- **Description**: Wait for text to appear or disappear or a specified time to pass
- **Parameters**:
  - `text` (string, Optional): The text to wait for
  - `textGone` (string, Optional): The text to wait for to disappear
  - `time` (number, Optional): The time to wait in seconds

## Best Practices & Guidelines

1. **Verify Parameters**: Double-check parameter names and types before invoking any tool. Missing required properties will cause errors.
2. **Minimize Output Bloat**: If a tool returns a large volume of data (e.g., file contents, search results), do NOT dump the entire payload to stdout. Instead, save the output to the scratch directory (`C:\Users\user\.gemini\antigravity\scratch`) and present only the summary to the user.
3. **Error Resilience**: If a tool call fails, log the error details, self-correct the parameters, and retry up to 3 times before reporting the error to the user.
4. **Security & Governance**: Respect all safety guidelines. Do not perform destructive actions (like deleting branches or repositories) without explicit user approval.
5. **User-Facing Artifacts in Korean**: When presenting artifacts, walkthroughs, or reports derived from these tools to the user, write them in Korean as per user policy.
