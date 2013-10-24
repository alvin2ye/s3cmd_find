def run(cmd)
  `#{cmd}`
end

def get_files(url)
  folders = []
  files = []
  res = run("s3cmd ls #{url}")
  #  DIR   s3://xxx/agicrm/
  #  2013-09-30 18:02   45  s3://xxx/agicrm/2013-10/db_production_20131001020206.tar.gz
  res.each_line do |line|
    raw = line.split
    if raw[0] == "DIR"
      # folders << raw.last
      get_files(raw.last)
    else
      puts line
    end
  end
end

def main
  get_files(ARGV.first)
end

main