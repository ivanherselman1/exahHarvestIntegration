public class HarvestUserHttpMockResponse implements HttpCallOutMock {

    public HttpResponse respond(HttpRequest req){
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(200);
        return res;
    }
}