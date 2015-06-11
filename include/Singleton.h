
#ifndef SINGLETON_H
#define SINGLETON_H

#ifndef WIN32
#include <pthread.h>
#endif
#include <stdlib.h> // atexit

template<typename T>
class Singleton
{
public:
	static T& instance()
	{
#ifndef WIN32
		pthread_once(&ponce_, &Singleton::init);
#else
		if (!value_)
			init();
#endif
		return *value_;
	}

private:
	  Singleton();
	  ~Singleton();

	  static void init()
	  {
		  value_ = new T();
		  ::atexit(destroy);
	  }

	  static void destroy()
	  {
		  delete value_;
	  }

private:
#ifndef WIN32
	  static pthread_once_t ponce_;
#endif
	  static T*             value_;
};

#ifndef WIN32
template<typename T>
pthread_once_t Singleton<T>::ponce_ = PTHREAD_ONCE_INIT;
#endif

template<typename T>
T* Singleton<T>::value_ = NULL;

#endif

