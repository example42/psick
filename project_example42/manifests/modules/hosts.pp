class hosts::example42 inherits hosts {

        File["hosts"] {
                content => template("project_example42/hosts/hosts.erb"),
        }

}
