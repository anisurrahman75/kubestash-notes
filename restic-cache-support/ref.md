https://forum.restic.net/t/how-much-faster-does-the-cache-make/3458



############### My personal test ###############################

-------------------- With Cache --------------------

➤ time restic backup demo_data_20gb
repository b1e31f3c opened (version 2, compression level auto)
created new cache in /home/anisur/RESTIC_DOC/restic-cache-dir
no parent snapshot found, will read all files
[0:00]          0 index files loaded

Files:           1 new,     0 changed,     0 unmodified
Dirs:            0 new,     0 changed,     0 unmodified
Added to the repository: 20.001 GiB (20.002 GiB stored)

processed 1 files, 20.000 GiB in 30:30
snapshot b7c0e2d5 saved

________________________________________________________
Executed in   30.59 mins    fish           external
   usr time  365.13 secs    0.00 micros  365.13 secs
   sys time  135.91 secs  450.00 micros  135.91 secs


➤ time restic check
using temporary cache in /home/anisur/RESTIC_DOC/restic-cache-dir/restic-check-cache-2757313661
create exclusive lock for repository
repository b1e31f3c opened (version 2, compression level auto)
created new cache in /home/anisur/RESTIC_DOC/restic-cache-dir/restic-check-cache-2757313661
load indexes
[0:02] 100.00%  4 / 4 index files loaded
check all packs
check snapshots, trees and blobs
[0:01] 100.00%  1 / 1 snapshots
no errors were found

________________________________________________________
Executed in   10.12 secs      fish           external
   usr time  636.39 millis    0.00 micros  636.39 millis
   sys time   75.13 millis  440.00 micros   74.69 millis


➤ time restic check --no-cache
create exclusive lock for repository
repository b1e31f3c opened (version 2, compression level auto)
load indexes
[0:02] 100.00%  4 / 4 index files loaded
check all packs
check snapshots, trees and blobs
[0:02] 100.00%  1 / 1 snapshots
no errors were found

________________________________________________________
Executed in   11.29 secs      fish           external
   usr time  641.37 millis    0.00 micros  641.37 millis
   sys time   73.25 millis  585.00 micros   72.67 millis


➤ du -sh restic-cache-dir
1.3M	restic-cache-dir

--------------------------------------





