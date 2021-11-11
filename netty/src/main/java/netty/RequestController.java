package netty;

import io.micronaut.http.MediaType;
import io.micronaut.http.annotation.*;

@Controller("/")
public class RequestController {

    @Get(uri="/ping", produces=MediaType.TEXT_PLAIN)
    public String ping() {
        return "pong";
    }
}