local M = {}

-- Raw multi-line galaxy text dataset block
local raw_galaxy_art = [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠰⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠂⠀⠈⡄⠀⠀⠀⡔⠂⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⠀⠀⠀⠀⠂⠀⠀⠐⠈⠀⠀⠄⠀⠀⠠⠴⠤⣴⣆⠴⣶⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠐⠀⠀⠀⠀⠀⠀⢑⠖⢀⡀⠀⠀⠀⠀⠀⠉⠑⠋⠁⠲⢶⣶⠂⠰⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠦⣀⢀⣁⣀⣤⡴⡿⣋⡴⣄⡠⠰⠖⡤⣄⣠⢀⡀⠀⡀⣠⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⡤⠄⠀⠀⠀⢀⠀⡀⠀⠀⠀⠈⠁⠀⠀⣀⣘⢀⣶⣶⢿⣛⠛⠋⠋⣉⠒⣂⠔⣭⢥⡙⠒⠀⡝⡷⢊⢋⠀⠌⡰⠓⣺⣻⡅⠀⡘⠉⠀⠄⠀⠀⠀⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⠀⠦⠌⠃⠀⠀⣄⠀⠀⠘⣟⠀⡂⠀⠈⣠⡤⡶⠛⢫⠜⢋⠀⠂⠦⠑⢀⢠⢨⠖⣠⣩⠦⡹⢴⢚⣂⡄⢉⠩⠐⠀⠐⠠⢁⠀⠀⠀⠀⠠⠜⠀⠀⣀⣰⠤⣐⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⠀⢀⡀⠁⣰⡀⠉⢿⠆⢀⣀⡠⣿⠝⣲⢛⠴⡲⣿⣷⣽⣼⡴⢦⣦⣤⣶⡴⣭⢏⡭⣐⢬⠰⢣⠬⣍⢣⠽⣙⣈⠀⠀⠄⠀⠀⢠⠀⠤⠁⠀⠀⡀⠀⠈⠘⠠⠀⢀⡀⠠⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠐⠦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⢀⣂⡨⠅⡤⡘⠄⠋⢐⠈⡐⣿⣿⣆⢠⠣⠌⣹⠶⢧⣻⢿⣿⠿⠬⡽⣿⣟⢿⣿⣯⣞⣶⣜⣀⡑⡫⢶⠌⠣⠎⠱⡌⢆⢃⠆⠁⠠⢃⡈⠠⢀⠈⠒⠠⠄⠒⠀⠀⠀⠀⠀⠀⠉⠒⠉⠐⢍⠤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣶⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠂⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⠈⠁⠀⠀⢘⡘⠖⢾⣤⣼⡳⠈⠁⠀⢘⠻⢿⣷⠋⡐⠃⠀⣨⣅⢌⡓⣦⣩⢍⣶⣬⣽⣴⣿⣿⠿⢯⢷⢂⣁⡉⠐⠢⣒⣄⠘⠔⠪⢌⡘⠐⢢⠀⠄⢃⠢⠘⡀⠂⠄⠂⠄⠀⠀⠠⠀⠀⠀⠀⠀⠈⠀⠂⠁⠐⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣄⡀⠀⠀⠀⡄⢐⡐⢆⣔⡻⢿⣫⣌⠈⡁⠡⣹⣷⢨⡀⣶⣄⠀⣿⠿⡐⣷⣷⣿⣿⣿⡿⢛⣩⣶⣶⣿⣿⣿⣷⣶⣾⣽⣓⡢⠌⠁⠈⡀⢄⠈⢁⠂⠅⡊⠄⡁⠆⢡⢉⠠⠡⠌⡀⠒⡀⡀⠀⢀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠑⠂⠄⠀⢀⣐⠾⠇⣙⣦⠹⣿⣿⠇⡀⣴⣿⢻⠁⢥⠀⢛⣚⠀⣧⡙⣽⣿⣿⣟⡟⣼⣿⣿⣿⡿⣹⣿⣿⣿⣽⣿⣻⣿⣿⣶⣆⡠⠀⠉⠓⣤⡔⠄⡀⠐⠀⠀⠂⠤⢁⠂⡐⢀⠂⠄⠀⠀⠀⠈⠈⠛⠰⠤⠀⠀⠀⠐⠀⠀⣡⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⠘⠌⢨⢴⣮⡛⣧⣍⠖⣽⣾⣿⣷⢉⡣⢈⡈⢘⠻⣠⠁⣧⢻⣿⣿⣻⣃⣿⣿⣿⣰⣿⡿⢟⣛⣛⣻⠻⣿⣿⣿⣽⣿⣿⣟⣦⣐⠶⢴⣻⡴⠆⡀⠧⢉⠆⠠⠁⠄⢂⠐⠈⠠⠀⠀⠂⠀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠁⡀⠣⠱⣙⣌⢿⡆⣙⠾⣶⡽⣷⡹⡆⡨⣌⠳⣽⣟⢬⡂⢻⣿⣿☗⣿⣿⣧⣾⣿⣰⣿⣿⣿⣿⣿⣷⣶⣮⡻⣿⣿⣿⣿⣿⣶⣦⣬⢶⡌⣅⣐⠃⢂⠤⢁⠌⠠⠈⠀⠐⠀⡁⠄⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠐⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⡄⡀⠀⠀⠀⢠⡀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠣⠩⣭⣎⡻⣿⣾⣄⢽⣿⣷⣁⠀⡨⣝⠞⣿⡟⢻⣿⣿⣿⣿⡘⣿⣿⣿⢱⣿⣿⣿⣿⣭⣽⣻⢿⣿⣿⣶⣉⢻⣿⣛⢿⣿⣿⣷⣦⣬⡉⢙⠲⡀⠁⠠⠀⠀⠀⠀⠀⠄⠀⠂⢀⠠⠀⠀⠀⠁⠀⠠⠄⡀⠀⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠁⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠈⠳⠤⢽⣻⣮⢿⣻⢦⡑⢾⣿⣦⠙⠲⣶⣽⣿⣏⣿⣿⣾⣿⣿⡘⣿⣿⣜⣿⣿⠛⠛⠛⠛⠿⣷⣟⢻⣿⣿⣿⣾⣝⣻⣿⣻⣿⣿⣿⣟⢦⣉⠘⠝⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡄⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠂⡈⠀⠀⠓⠒⠒⢿⣯⠭⡳⠍⠀⠘⢻⣗⡂⠛⢿⣿⣿⡿⣿⣿⠾⣿⣿⣶⡙⣿⣿⡟⠀⠀⠀⠀⠀⠀⠈⠹⣿⣿⣿⣿⣿⣿⣷⣶⡹⢿⣿⣿⣷⣜⠷⣀⠙⢷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠰⠀⢉⠈⡾⣀⣈⠹⢷⣆⠈⠀⢿⣿⣿⡀⠀⡉⢏⣿⣎⢿⣿⣶⣛⣿⣿⣶⣬⣝⡢⠀⠀⠀⠀⠀⠀⠀⠸⣿⣷⣦⣙⢿⣿⣟⣿⣿⣽⢻⣿⣿⣷⠉⣷⡀⠆⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠒⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⠂⠨⠙⠶⡩⣕⠦⢄⠰⣎⠀⠀⡉⠛⢿⣷⡄⢴⣌⣻⣷⣝⠿⣿⣶⣽⢻⣿⣿⣿⣷⣦⣄⣀⠀⠀⠀⣸⣿⣿⣿⣿⡜⢿⣿⣿⣿⣿⡹⣿⣿⣿⣷⡄⠐⣄⠙⠆⣢⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠴⠀⠀⠀⠀⠀⠂⠁⠀⠂⢀⠀⠄⠘⠲⢷⣇⠓⠠⢂⠻⡔⠦⠀⠙⢿⣷⣠⣙⠿⣿⣿⣿⣛⢿⢿⣿⣿⣾⣿⣾⣿⣿⣿⠿⣿⣿⣿⣿⣿⣿⣷⢹⣿⣿⣿⣿⣖⣿⣿⣻⣿⣧⠛⠤⠡⡈⠻⣿⣷⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⡀⠀⠂⠀⡀⠀⠀⠀⠀⠀⠀⠂⠄⠠⠀⠹⡟⢞⢮⡀⢁⡀⢛⡰⢌⠋⠽⣿⣷⣝⣿⣿⣿⣿⣷⣶⣭⣙⣛⣛⣛⣫⣶⣾⣿⣿⣿⡇⣿⣿⣽⣷⢹⣿⡿⣿⡟⢻⣿⣿⣿⣿⠟⣨⠇⠁⠀⠈⢹⣷⣀⠀⠀⠀⠀⠀⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⢨⣁⠀⡀⠀⠁⠀⠀⠀⠀⠁⡀⠘⠂⠄⠽⠢⣒⣣⢉⢎⡂⠑⣀⡐⢿⠳⣾⣭⣛⣿⠿⣿⣿⣿⣿⣿⣿⣿⡿⢛⣛⣭⣾⣿⣿⣻⣿⢺⣿⡧⣿⣿⡾⣿⣾⣿⣿⣧⡹⡅⢓⠀⡀⠈⠿⢿⣆⡀⠀⠀⠤⢠⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠤⠀⡉⠂⣀⠀⠠⠀⠠⠀⠀⠀⠀⠀⠈⠠⡁⠔⢚⠩⠂⢀⠆⡁⠦⡙⠆⢢⣙⠷⣿⣿⣿⣶⣝⡻⢿⣷⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⡿⣸⣿⡧⣿⣿⣧⣿⣿⣼⣿⣝⣅⡈⠦⠁⠀⠐⠩⣌⣿⣷⠀⠀⠄⠁⡈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠃⠠⡄⢀⠀⠀⠀⠀⠀⠡⡐⠂⠈⠐⡈⠄⠂⡉⢖⡩⢓⡢⡑⢦⠈⠹⣿⣿⣛⣿⣷⣴⣬⣭⣭⣙⣛⣛⣛⣛⣹⣭⣴⣾⣿⢏⣾⣿⣿⣽⣿⣿⣿⡆⢍⢧⠳⣈⠐⠀⠀⠘⣿⡻⢵⡐⡤⠒⠀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠀⠀⠀⠙⠈⠀⠄⠀⠀⡀⠐⠀⠄⠀⠁⠀⠐⠂⠬⢐⡓⣂⣃⠐⢢⠄⣢⢉⠒⠾⠿⢽⣭⣭⣿⣿⣿⣿⣿⣿⢿⣿⣟⣻⢟⣛⣼⣿⣿⣿⢿⣿⣿⡋⠝⡘⡇⠀⠹⠀⣐⢂⠀⠸⣯⠐⡟⢔⢦⡀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⣐⢢⡒⠀⠀⡀⠉⢐⡂⠀⡄⠈⠀⠀⠀⠀... [truncated for size due to exact literal mapping matching]
]]

-- Set color spaces
vim.api.nvim_set_hl(0, "GalaxyIntroOrange", { fg = "#FE8019", bold = true })
vim.api.nvim_set_hl(0, "GalaxyIntroBlue",   { fg = "#83A598" })
vim.api.nvim_set_hl(0, "GalaxyIntroPurple", { fg = "#D3869B" })

function M.play()
  local buf = vim.api.nvim_create_buf(false, true)
  local ns = vim.api.nvim_create_namespace("GalaxyIntroSpace")
  
  local src_lines = {}
  for line in raw_galaxy_art:gmatch("[^\r\n]+") do
    local chars = {}
    for char in line:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
      table.insert(chars, char)
    end
    table.insert(src_lines, chars)
  end

  local height = #src_lines
  local width = 0
  for _, chars in ipairs(src_lines) do
    if #chars > width then width = #chars end
  end

  local center_y = height / 2
  local center_x = width / 2

  -- Layout Calculations
  local screen_width = vim.o.columns
  local screen_height = vim.o.lines

  -- Scale window dimensions dynamically to avoid clipping small terminals
  local win_width = math.min(width, screen_width - 4)
  local win_height = math.min(height, math.floor(screen_height * 0.45)) -- Bound strictly within top 45% region

  -- POSITION FIX: Centered horizontally, anchored cleanly above 50% screen height marks
  local col_pos = math.max(0, math.floor((screen_width - win_width) / 2))
  local row_pos = math.max(1, math.floor((screen_height * 0.5) - win_height - 2)) 

  local opts = {
    relative = "editor",
    width = win_width,
    height = win_height,
    col = col_pos,
    row = row_pos,
    style = "minimal",
    border = "none", -- Borderless fits inline dashboard look better
    focusable = false,
    noautocmd = true
  }
  
  local win = vim.api.nvim_open_win(buf, false, opts) -- false ensures user keeps control of prompt below
  vim.bo[buf].buftype = "nofile"

  local timer = vim.uv.new_timer()
  local frame = 0

  timer:start(0, 50, vim.schedule_wrap(function()
    -- Automatically terminate loop if user opens another buffer, files layout, or changes tabs
    if not vim.api.nvim_win_is_valid(win) or not vim.api.nvim_buf_is_valid(buf) or vim.fn.argc() > 0 then
      timer:stop()
      timer:close()
      if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
      return
    end

    frame = frame + 1
    local theta = frame * 0.03
    local cos_t = math.cos(theta)
    local sin_t = math.sin(theta)

    local render_grid = {}
    for y = 1, height do
      render_grid[y] = {}
      for x = 1, width do render_grid[y][x] = "⠀" end
    end

    local color_map = {}

    for y = 1, height do
      for x = 1, #src_lines[y] do
        local char = src_lines[y][x]
        if char ~= "⠀" and char ~= " " and char ~= "" then
          local dy = (y - center_y) * 2.1
          local dx = (x - center_x)

          local rx = dx * cos_t - dy * sin_t
          local ry = (dx * sin_t + dy * cos_t) / 2.1

          local nx = math.floor(rx + center_x + 0.5)
          local ny = math.floor(ry + center_y + 0.5)

          if ny >= 1 and ny <= height and nx >= 1 and nx <= width then
            render_grid[ny][nx] = char
            
            local dist = math.sqrt(dx*dx + dy*dy)
            local hash = (x * 17 + y * 31 + frame) % 100
            
            if hash < 8 then
              color_map[ny] = color_map[ny] or {}
              color_map[ny][nx] = "GalaxyIntroOrange"
            elseif dist > 40 and hash > 92 then
              color_map[ny] = color_map[ny] or {}
              color_map[ny][nx] = "GalaxyIntroPurple"
            elseif hash > 40 and hash < 46 then
              color_map[ny] = color_map[ny] or {}
              color_map[ny][nx] = "GalaxyIntroBlue"
            end
          end
        end
      end
    end

    -- Clamp and map current window grid slices dynamically to fit window cuts
    local flat_lines = {}
    for y = 1, win_height do
      table.insert(flat_lines, table.concat(render_grid[y], "", 1, win_width))
    end

    vim.bo[buf].modifiable = true
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, flat_lines)
    vim.bo[buf].modifiable = false

    -- Inject dynamic Extmark styling rows
    vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
    for y = 1, win_height do
      if color_map[y] then
        for x, hl_group in pairs(color_map[y]) do
          if x <= win_width then
            local prefix_str = table.concat(render_grid[y], "", 1, x - 1)
            local byte_col = #prefix_str
            local char_len = #render_grid[y][x]

            vim.api.nvim_buf_set_extmark(buf, ns, y - 1, byte_col, {
              end_row = y - 1,
              end_col = byte_col + char_len,
              hl_group = hl_group
            })
          end
        end
      end
    end
  end))

  -- Automatically tear down the spinning animation tracking the exact moment editing actions begin
  local clear_anim_group = vim.api.nvim_create_augroup("GalaxyIntroKill", { clear = true })
  vim.api.nvim_create_autocmd({ "BufReadCmd", "BufNewFile", "InsertEnter", "BufWinLeave" }, {
    group = clear_anim_group,
    once = true,
    callback = function()
      timer:stop()
      timer:close()
      if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
    end
  })
end

-- Hook into Neovim launch script loop layout triggers automatically
if vim.fn.argc() == 0 then
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      M.play()
    end
  })
end

return M

