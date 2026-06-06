/**
 * Hook personalizzato per il caricamento dei file
 */

import { useState, useCallback } from 'react';
import { ipcService } from '../services/ipcService';

interface UseFileLoaderReturn {
  isLoading: boolean;
  error: string | null;
  openFile: () => Promise<any>;
}

export const useFileLoader = (): UseFileLoaderReturn => {
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const openFile = useCallback(async () => {
    setIsLoading(true);
    setError(null);

    try {
      const filePath = await ipcService.openFile('rbxl,rbxlx,rbxm');
      if (filePath) {
        const result = await ipcService.analyzeFile(filePath);
        return result;
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Unknown error');
    } finally {
      setIsLoading(false);
    }
  }, []);

  return { isLoading, error, openFile };
};
