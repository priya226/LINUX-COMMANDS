# Simple Backup Script (Shell)

This task is a small **shell script** (`backup.sh`) that automates a basic folder backup and can be reused for different directories.

## What `backup.sh` does

`backup.sh`:

- Takes two arguments:
  - `<source_dir>` – directory to back up.
  - `<dest_dir>` – directory where the backup is stored.
- Checks:
  - both arguments are provided,
  - the source directory exists.
- Creates the destination directory if needed.
- Copies the **contents** of the source into the destination.
- Prints a **timestamped** message like:
--[YYYY-MM-DD HH:MM:SS] SYNCED THE DATA FROM <source_dir> TO <dest_dir>


The goal is simple: **automate** “copy this folder to that backup location”.

## Usage (manual)

From inside this folder:

chmod +x backup.sh # first time only
./backup.sh <source_dir> <dest_dir>

Example:
./backup.sh /home/user/documents /home/user/backups/documents

You can also log the output:
./backup.sh /home/user/documents /home/user/backups/documents >> backup.log 2>&1


- `>> backup.log` → append output to `backup.log`.
- `2>&1` → send errors to the same log file.

## Scheduling with cron

**cron** is a scheduler that runs commands at specified times (only when the machine is on).

Edit your user crontab:

crontab -e


Example: run two backups every day at midnight and log to a file:
0 0 * * * /full/path/to/backup.sh /home/user/docs /home/user/backups/docs >> /home/user/backup.log 2>&1
0 0 * * * /full/path/to/backup.sh /home/user/photos /home/user/backups/photos >> /home/user/backup.log 2>&1



- `0 0 * * *` → minute, hour, day-of-month, month, day-of-week.
- Here: “at 00:00 every day”.
- `backup.sh` is **reusable** because it takes `<source_dir> <dest_dir>` as arguments.

> Limitation: if the machine is **off** at 00:00, cron will **skip** that run.

## anacron (for laptops / not always-on machines)

If you want “run once per day” even when the machine is often off at midnight, use **anacron**.

Concept:

- `cron` → “run at this exact time” (machine must be on).
- `anacron` → “run once per day/week/month; if missed, run soon after the machine is on”.

On many Linux systems, you can place scripts or calls into:

- `/etc/cron.daily/` (often managed by anacron),
- or configure `/etc/anacrontab` to call `backup.sh` with your desired arguments.

Example idea (not exact config):

1 10 my-backup /full/path/to/backup.sh /home/user/docs /home/user/backups/docs


- `1` → run once per day.
- `10` → run ~10 minutes after the machine is powered on, if it hasn’t run in the last day.

This way your backup still runs daily even if the laptop was off at midnight.

---

This task demonstrates:

- basic bash scripting,
- passing arguments (`$1`, `$2`),
- simple validation,
- timestamps with `date`,
- and using `cron`/`anacron` for automation.





