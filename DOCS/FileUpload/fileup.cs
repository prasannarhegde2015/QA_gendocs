 public static  void UploadFile(IWebElement elem, string path)
        {
            var allowsDetection = driver as IAllowsFileDetection;
            if (allowsDetection != null)
            {
                allowsDetection.FileDetector = new LocalFileDetector();
            }
            string jsscript = "arguments[0].style.visibility = 'visible'; arguments[0].style.height = '1px'; arguments[0].style.width = '1px';  arguments[0].style.opacity = 1";
            ((IJavaScriptExecutor)driver).ExecuteScript(jsscript, elem);
            elem.SendKeys(path);
        }
        
        
        //Call Works on Chrome or IE not Edge Browser
         SeleniumActions.UploadFile(PageObjects.LocalEdgeTest.fileControl, @"E:\log1.txt");
