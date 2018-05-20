package com.aon.lib.http;

import java.io.InputStream;
import java.io.OutputStream;

import com.aon.lib.repo.Repository;
import com.aon.lib.repo.RepositoryFile;
import com.aon.lib.repo.RepositoryService;


/**
 * HTTP multipart 방식으로 upload된 파일에 대한 저장소이다.
 * <p>
 * upload된 파일은 MultipartRepository에 저장된다. 이때의 path는 input type="file"에서의 name이
 * 된다.
 */
public class MultipartRepository implements Repository
{
    /**
     * 해당 path 의 파일을 OutputStream 으로 출력한다.
     */
    public long write(String path, OutputStream os) throws Exception
    {
        return write(path, os, 0);
    }

    /**
     * 해당 Path 의 파일을 주어진 offset 부터 끝까지 OutputStream 으로 출력한다.
     */
    public long write(String path, OutputStream os, long offset)
        throws Exception
    {
        InputStream is = null;
        try
        {
            is = MultipartContext.getMultipartContext().getFile(path)
                .getInputStream();
            return RepositoryService.copy(is, os, offset);
        }
        finally
        {
            if (is != null)
            {
                is.close();
            }
        }
    }


    /**
     * 저장할 수 없다. UnsupportedOperationException을 던진다.
     */
    public String store(RepositoryFile file) throws Exception
    {
        throw new UnsupportedOperationException();
    }

    /**
     * 이후 자동으로 삭제되므로 아무일도 하지 않는다.
     */
    public void delete(String path) throws Exception
    {
    }

    public long write(String path, String dst) throws Exception
    {
        throw new UnsupportedOperationException();
    }

}
