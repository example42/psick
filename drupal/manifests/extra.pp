#
# Class: drupal::extra
#
# A predefined set of modules and them to include 
# out of the box,
#
# Usage:
# Autoincluded by drupal class
#
class drupal::extra {

    drupal::module { "ctools":  }
    drupal::module { "views":  }
    drupal::module { "panels":  }
    drupal::module { "multiblock":  }
    drupal::module { "admin_menu":  }
    drupal::module { "advanced_help":  }

    drupal::module { "cck":  }
    drupal::module { "imce":  }
    drupal::module { "xml_sitemap":  }
    drupal::module { "webform":  }
    drupal::module { "google_analytics":  }
    drupal::module { "seo_checklist":  }
    drupal::module { "github":  }
    drupal::module { "gitbrowser":  }
    drupal::module { "flickr":  }
    drupal::module { "wysiwyg":  }
    drupal::module { "jwysiwyg":  }
    drupal::module { "wymeditor":  }

    drupal::module { "addtoany":  }
    drupal::module { "syntaxhighlighter":  }
    drupal::theme { "zen":  }
    drupal::theme { "corolla":  }
    drupal::theme { "danland":  }
    drupal::theme { "mayo":  }
    drupal::theme { "tarski":  }

}
