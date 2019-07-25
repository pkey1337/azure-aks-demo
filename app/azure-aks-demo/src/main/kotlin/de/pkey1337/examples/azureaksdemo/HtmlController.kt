package de.pkey1337.examples.azureaksdemo

import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.ui.set
import org.springframework.web.bind.annotation.GetMapping

@Controller
class HtmlController {

    @GetMapping("/")
    fun demo(model: Model): String {
        model["title"] = "Azure AKS Demo"
        return "demopage"
    }

}