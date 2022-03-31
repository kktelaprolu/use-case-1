output instance_id {
  description = "An identifier for the resource with format {{project}}/{{name}}"
  value = google_spanner_instance.spanner_instance.id
}

output databases_names {
  description = "An identifier for the resource with format {{instance}}/{{name}}"
  value = {
       for name, database in google_spanner_database.spanner_database :
        name => database.id
	      }
		               }					   
	