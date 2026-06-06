/**
 * Logger utility for USSI Studio
 */

export enum LogLevel {
  Debug = 'DEBUG',
  Info = 'INFO',
  Warn = 'WARN',
  Error = 'ERROR',
}

export interface Logger {
  debug(message: string, ...args: any[]): void;
  info(message: string, ...args: any[]): void;
  warn(message: string, ...args: any[]): void;
  error(message: string, ...args: any[]): void;
}

class ConsoleLogger implements Logger {
  private level: LogLevel = LogLevel.Info;

  constructor(level: LogLevel = LogLevel.Info) {
    this.level = level;
  }

  debug(message: string, ...args: any[]): void {
    if (this.shouldLog(LogLevel.Debug)) {
      console.debug(`[${LogLevel.Debug}]`, message, ...args);
    }
  }

  info(message: string, ...args: any[]): void {
    if (this.shouldLog(LogLevel.Info)) {
      console.info(`[${LogLevel.Info}]`, message, ...args);
    }
  }

  warn(message: string, ...args: any[]): void {
    if (this.shouldLog(LogLevel.Warn)) {
      console.warn(`[${LogLevel.Warn}]`, message, ...args);
    }
  }

  error(message: string, ...args: any[]): void {
    if (this.shouldLog(LogLevel.Error)) {
      console.error(`[${LogLevel.Error}]`, message, ...args);
    }
  }

  private shouldLog(level: LogLevel): boolean {
    const levels = [LogLevel.Debug, LogLevel.Info, LogLevel.Warn, LogLevel.Error];
    return levels.indexOf(level) >= levels.indexOf(this.level);
  }
}

export const logger = new ConsoleLogger();
