package com.rydogs.springbootdemo.web

import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestParam

@Controller
class TestController {
    @GetMapping("/hello")
    fun hello(@RequestParam(name="name", required = false) name: String? = "stranger"): String {
        return "hello $name"
    }
}