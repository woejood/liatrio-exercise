kubectl get nodes
kubectl get services
kubectl get pod liatrio-api-867d8b77fc-64vcc
Write-Host(" ")
Write-Host("--------")
Write-Host(" " )
curl http://20.75.47.26:5000/ | Select-Object -ExpandProperty Content