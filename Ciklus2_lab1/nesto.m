name = "2.txt";
start = 1;
samples = 510;
rho_start = 16;
rho_end = 64;
method = 'relative magnitude';
[autocorr,peak_direct,index_direct] = Primer1_IIciklus(read_data(name),name,start,samples,rho_start,rho_end, method)