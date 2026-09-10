############################################################
					# CUESTIONARIO 6 #
############################################################


import geopandas as gpd


# PREGUNTA 1


#¿Qué código escribirías para leer el archivo shapefile (shp) de ciudades del mundo y quedarte con aquellas que pertenecen a Argentina? Recordar que el nombre de la columna correspondiente al país en el GeoDataFrame del mundo ("naturalearth lowres") es "name".

gdf_mask=gpd.read_file(gpd.datasets.get_path("naturalearth_lowres"))
gdf=gpd.read_file(gpd.datasets.get_path("naturalearth_cities"),mask=gdf_mask[gdf_mask.name=="Argentina"])
print(gdf)


# PREGUNTA 2


#El área en kilómetros cuadrados de cada país en el GeoDataFrame mundo_gdf se puede calcular como mundo_gdf.to_crs('proj':'cea').area / 1e6. Sabiendo esto, ¿qué código escribirías para generar un mapa donde cada país esté pintado de acuerdo a su densidad de población?

mundo_gdf=gpd.read_file(gpd.datasets.get_path("naturalearth_lowres"))
print(mundo_gdf)
mundo_gdf['area_km2']=mundo_gdf.to_crs({'proj':'cea'}).area/1e6
print(mundo_gdf)
pp=mundo_gdf.plot(figsize=(20,10),column='area_km2',legend=True,legend_kwds={'label': 'Área en km2', 'orientation': 'horizontal'})