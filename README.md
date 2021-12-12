# DeepStack AI Server DEMO

This is a demo showing how to use DeepStack AI Server, from Delphi. 

Inorder for this demo to work it's a prerequisite that you have downloaded, installed and started DeepStack AI Server.

## About  DeepStack

DeepStack is an [Open-Source](https://github.com/johnolafenwa/deepstack) AI API engine that serves pre-built models and custom models on multiple edge devices locally or on your private cloud. Click [here](https://docs.deepstack.cc/index.html#installation) to download your own copy. 

For more information read about the project please [goto](https://deepstack.cc/) their home page.

![image](https://user-images.githubusercontent.com/8626074/145703497-479a0120-3759-4dd1-b980-843f2a9fc861.png)


## Inspiration

I got the inspiration for this watching [Alister Christie](http://learndelphi.tv/) video about it.  You can watch the video by clicking on the image below[![Watch the video here](https://user-images.githubusercontent.com/8626074/145675941-3efa5a68-97e7-4386-b65f-1e96e10e72c8.png)](https://www.youtube.com/watch?v=cGeTR09yudw)


## The Code

While Alister Christie was hand parsing the JSON result I'm using my own tool [Delphi-JsonToDelphiClass
](https://github.com/JensBorrisholt/Delphi-JsonToDelphiClass) for auto generating generating. So instead of witeteing code like this:

```pascal
var j := TJsonObject.ParseJsonValue(Response.ContentAsString);
var s := j.FindValue('sucess')

if s-AsType<string> = 'false' then
begin
   ..
end;
```

My tool generates a simple class taking care of all the JSON stuff

 ```pascal
  TObjectDetectionResult = class(TJsonDTO)
---
  published
    property Duration: Integer read FDuration write FDuration;
    property Predictions: TObjectList<TPredictions> read GetPredictions;
    property Success: Boolean read FSuccess write FSuccess;
  public
---   
  end;
```

And the use of it is even more simple:

```pascal
var detectionResult := TObjectDetectionResult.Create;
detectionResult.AsJSON :=  Response.ContentAsString;

if detectionResult.Success then
begin
  ---
end;
```

Besides from this I've done some cleanup of the code. 

It's all incluuded in this repo. 

## Json To Delphi

The tool [Delphi-JsonToDelphiClass](https://github.com/JensBorrisholt/Delphi-JsonToDelphiClass) is of cause also to be found here on Github. An of cause it's free and open source. 
