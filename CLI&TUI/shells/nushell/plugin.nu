register C:\Users\24138\scoop\apps\nu\0.92.2\nu_plugin_gstat.exe  {
  "sig": {
    "name": "gstat",
    "usage": "Get the git status of a repo",
    "extra_usage": "",
    "search_terms": [],
    "required_positional": [],
    "optional_positional": [
      {
        "name": "path",
        "desc": "path to repo",
        "shape": "Filepath",
        "var_id": null,
        "default_value": null
      }
    ],
    "rest_positional": null,
    "named": [
      {
        "long": "help",
        "short": "h",
        "arg": null,
        "required": false,
        "desc": "Display the help message for this command",
        "var_id": null,
        "default_value": null
      }
    ],
    "input_output_types": [],
    "allow_variants_without_examples": false,
    "is_filter": false,
    "creates_scope": false,
    "allows_unknown_args": false,
    "category": {
      "Custom": "prompt"
    }
  },
  "examples": []
}

register C:\Users\24138\.cargo\bin\nu_plugin_highlight.exe  {
  "sig": {
    "name": "highlight",
    "usage": "Syntax highlight source code.",
    "extra_usage": "",
    "search_terms": [
      "syntax",
      "highlight",
      "highlighting"
    ],
    "required_positional": [],
    "optional_positional": [
      {
        "name": "language",
        "desc": "language or file extension to help language detection",
        "shape": "String",
        "var_id": null,
        "default_value": null
      }
    ],
    "rest_positional": null,
    "named": [
      {
        "long": "help",
        "short": "h",
        "arg": null,
        "required": false,
        "desc": "Display the help message for this command",
        "var_id": null,
        "default_value": null
      },
      {
        "long": "theme",
        "short": "t",
        "arg": "String",
        "required": false,
        "desc": "them used for highlighting",
        "var_id": null,
        "default_value": null
      },
      {
        "long": "list-themes",
        "short": null,
        "arg": null,
        "required": false,
        "desc": "list all possible themes",
        "var_id": null,
        "default_value": null
      }
    ],
    "input_output_types": [
      [
        "String",
        "String"
      ],
      [
        "Any",
        {
          "Table": [
            [
              "id",
              "String"
            ],
            [
              "name",
              "String"
            ],
            [
              "author",
              "String"
            ],
            [
              "default",
              "Bool"
            ]
          ]
        }
      ]
    ],
    "allow_variants_without_examples": false,
    "is_filter": false,
    "creates_scope": false,
    "allows_unknown_args": false,
    "category": "Strings"
  },
  "examples": [
    {
      "example": "open Cargo.toml -r | highlight toml",
      "description": "Highlight a toml file by its file extension",
      "result": null
    },
    {
      "example": "open src/main.rs | highlight Rust",
      "description": "Highlight a rust file by programming language",
      "result": null
    },
    {
      "example": "open example.sh | highlight",
      "description": "Highlight a bash script by inferring the language (needs shebang)",
      "result": null
    },
    {
      "example": "open Cargo.toml -r | highlight toml -t ansi",
      "description": "Highlight a toml file with another theme",
      "result": null
    },
    {
      "example": "highlight --list-themes",
      "description": "List all available themes",
      "result": null
    }
  ]
}

register C:\Users\24138\scoop\apps\nu\0.92.2\nu_plugin_inc.exe  {
  "sig": {
    "name": "inc",
    "usage": "Increment a value or version. Optionally use the column of a table.",
    "extra_usage": "",
    "search_terms": [],
    "required_positional": [],
    "optional_positional": [
      {
        "name": "cell_path",
        "desc": "cell path to update",
        "shape": "CellPath",
        "var_id": null,
        "default_value": null
      }
    ],
    "rest_positional": null,
    "named": [
      {
        "long": "help",
        "short": "h",
        "arg": null,
        "required": false,
        "desc": "Display the help message for this command",
        "var_id": null,
        "default_value": null
      },
      {
        "long": "major",
        "short": "M",
        "arg": null,
        "required": false,
        "desc": "increment the major version (eg 1.2.1 -> 2.0.0)",
        "var_id": null,
        "default_value": null
      },
      {
        "long": "minor",
        "short": "m",
        "arg": null,
        "required": false,
        "desc": "increment the minor version (eg 1.2.1 -> 1.3.0)",
        "var_id": null,
        "default_value": null
      },
      {
        "long": "patch",
        "short": "p",
        "arg": null,
        "required": false,
        "desc": "increment the patch version (eg 1.2.1 -> 1.2.2)",
        "var_id": null,
        "default_value": null
      }
    ],
    "input_output_types": [],
    "allow_variants_without_examples": false,
    "is_filter": false,
    "creates_scope": false,
    "allows_unknown_args": false,
    "category": "Default"
  },
  "examples": []
}

register C:\Users\24138\scoop\apps\nu\0.92.2\nu_plugin_query.exe  {
  "sig": {
    "name": "query",
    "usage": "Show all the query commands",
    "extra_usage": "",
    "search_terms": [],
    "required_positional": [],
    "optional_positional": [],
    "rest_positional": null,
    "named": [
      {
        "long": "help",
        "short": "h",
        "arg": null,
        "required": false,
        "desc": "Display the help message for this command",
        "var_id": null,
        "default_value": null
      }
    ],
    "input_output_types": [],
    "allow_variants_without_examples": false,
    "is_filter": false,
    "creates_scope": false,
    "allows_unknown_args": false,
    "category": "Filters"
  },
  "examples": []
}

register C:\Users\24138\scoop\apps\nu\0.92.2\nu_plugin_query.exe  {
  "sig": {
    "name": "query json",
    "usage": "execute json query on json file (open --raw <file> | query json 'query string')",
    "extra_usage": "",
    "search_terms": [],
    "required_positional": [
      {
        "name": "query",
        "desc": "json query",
        "shape": "String",
        "var_id": null,
        "default_value": null
      }
    ],
    "optional_positional": [],
    "rest_positional": null,
    "named": [
      {
        "long": "help",
        "short": "h",
        "arg": null,
        "required": false,
        "desc": "Display the help message for this command",
        "var_id": null,
        "default_value": null
      }
    ],
    "input_output_types": [],
    "allow_variants_without_examples": false,
    "is_filter": false,
    "creates_scope": false,
    "allows_unknown_args": false,
    "category": "Filters"
  },
  "examples": []
}

register C:\Users\24138\scoop\apps\nu\0.92.2\nu_plugin_query.exe  {
  "sig": {
    "name": "query web",
    "usage": "execute selector query on html/web",
    "extra_usage": "",
    "search_terms": [],
    "required_positional": [],
    "optional_positional": [],
    "rest_positional": null,
    "named": [
      {
        "long": "help",
        "short": "h",
        "arg": null,
        "required": false,
        "desc": "Display the help message for this command",
        "var_id": null,
        "default_value": null
      },
      {
        "long": "query",
        "short": "q",
        "arg": "String",
        "required": false,
        "desc": "selector query",
        "var_id": null,
        "default_value": null
      },
      {
        "long": "as-html",
        "short": "m",
        "arg": null,
        "required": false,
        "desc": "return the query output as html",
        "var_id": null,
        "default_value": null
      },
      {
        "long": "attribute",
        "short": "a",
        "arg": "String",
        "required": false,
        "desc": "downselect based on the given attribute",
        "var_id": null,
        "default_value": null
      },
      {
        "long": "as-table",
        "short": "t",
        "arg": {
          "List": "String"
        },
        "required": false,
        "desc": "find table based on column header list",
        "var_id": null,
        "default_value": null
      },
      {
        "long": "inspect",
        "short": "i",
        "arg": null,
        "required": false,
        "desc": "run in inspect mode to provide more information for determining column headers",
        "var_id": null,
        "default_value": null
      }
    ],
    "input_output_types": [],
    "allow_variants_without_examples": false,
    "is_filter": false,
    "creates_scope": false,
    "allows_unknown_args": false,
    "category": "Network"
  },
  "examples": [
    {
      "example": "http get https://phoronix.com | query web --query 'header' | flatten",
      "description": "Retrieve all `<header>` elements from phoronix.com website",
      "result": null
    },
    {
      "example": "http get https://en.wikipedia.org/wiki/List_of_cities_in_India_by_population |\n        query web --as-table [City 'Population(2011)[3]' 'Population(2001)[3][a]' 'State or unionterritory' 'Ref']",
      "description": "Retrieve a html table from Wikipedia and parse it into a nushell table using table headers as guides",
      "result": null
    },
    {
      "example": "http get https://www.nushell.sh | query web --query 'h2, h2 + p' | each {str join} | group 2 | each {rotate --ccw tagline description} | flatten",
      "description": "Pass multiple css selectors to extract several elements within single query, group the query results together and rotate them to create a table",
      "result": null
    },
    {
      "example": "http get https://example.org | query web --query a --attribute href",
      "description": "Retrieve a specific html attribute instead of the default text",
      "result": null
    }
  ]
}

register C:\Users\24138\scoop\apps\nu\0.92.2\nu_plugin_query.exe  {
  "sig": {
    "name": "query xml",
    "usage": "execute xpath query on xml",
    "extra_usage": "",
    "search_terms": [],
    "required_positional": [
      {
        "name": "query",
        "desc": "xpath query",
        "shape": "String",
        "var_id": null,
        "default_value": null
      }
    ],
    "optional_positional": [],
    "rest_positional": null,
    "named": [
      {
        "long": "help",
        "short": "h",
        "arg": null,
        "required": false,
        "desc": "Display the help message for this command",
        "var_id": null,
        "default_value": null
      }
    ],
    "input_output_types": [],
    "allow_variants_without_examples": false,
    "is_filter": false,
    "creates_scope": false,
    "allows_unknown_args": false,
    "category": "Filters"
  },
  "examples": []
}

