# LOG

A simple command-line utility that helps you maintain daily logs with AI-powered summaries. The script uses Ollama (running Mistral locally) to automatically summarize your entries and can help track tasks across your logs.

## Features

- Create timestamped log entries with AI-generated summaries
- View logs for today or yesterday
- Extract and summarize tasks from your daily logs
- All logs are automatically organized by date in `.aux/log` directory

## Prerequisites

- [Ollama](https://ollama.ai/) installed and running
- Mistral model pulled (`ollama pull mistral`)
- Bash shell environment

## Getting Started

1. Clone this repository or download the script:

   ```bash
   git clone [repository-url]
   ```

2. Make the script executable:

   ```bash
   chmod +x log_script.sh
   ```

3. Optional: Add to your zshrc
   ```bash
    # For zsh users:
   echo 'alias log="/path/to/log.sh"' >> ~/.zshrc
   source ~/.zshrc
   ```

## Usage

The script can be used in two ways: with direct commands or interactively.

### Direct Commands

```bash
# View today's logs
log today
# or
log day

# View yesterday's logs
log yesterday

# List tasks from today's logs
log tasks

# View help
log help

# Create a new log entry directly
log This is my log entry for today
```

### Interactive Mode

Run the script without arguments and follow the prompts:

```bash
log
What would you like to log?
> show day     # Shows today's logs
> show yesterday    # Shows yesterday's logs
> list tasks  # Lists tasks from today's logs
> help        # Shows help message
> [any text]  # Creates a new log entry
```

All logs are automatically saved in `.aux/log` with the filename format `log-MM-YYYY-DD.md`.
