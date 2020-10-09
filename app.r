json_file <- "https://services1.arcgis.com/CY1LXxl9zlJeBuRZ/arcgis/rest/services/Florida_COVID19_Case_Line_Data_NEW/FeatureServer/0/query?where=County%20%3D%20'LEON'&resultOffset=2000&outFields=*&outSR=4326&f=json"
json_data <- fromJSON(json_file)
json_data <- json_data[["features"]] %>% as.data.frame

transfer_limit <- TRUE
result_offset <- 0
while(transfer_limit==TRUE) {
	json_url <- paste("https://services1.arcgis.com/CY1LXxl9zlJeBuRZ/arcgis/rest/services/Florida_COVID19_Case_Line_Data_NEW/FeatureServer/0/query?where=1%3D1&resultOffset=", result_offset, "&outFields=*&outSR=4326&f=json", sep="")
    import_data <- fromJSON(json_url)
	transfer_limit <- import_data["exceededTransferLimit"]
    json_data <- rbind(json_data, as.matrix(import_data[["features"]]))
	
	result_offset + 2000
}
