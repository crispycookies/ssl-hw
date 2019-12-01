/////////////////////////////////////////////////////////////
// Author: Patrick Wuerflinger
// Filename: Settings.h
// Description: Header file for the concurrent queue
// Revision: 0
/////////////////////////////////////////////////////////////

#ifndef CONCURRENTQUEUE_H
#define CONCURRENTQUEUE_H

#include <queue>
#include <thread>
#include <mutex>
#include <condition_variable>

template <typename T>
	class ConcurrentQueue
	{
	public:
		ConcurrentQueue() = default;
		ConcurrentQueue(const ConcurrentQueue&) = delete;                // disable copying
		ConcurrentQueue& operator=(const ConcurrentQueue&) = delete;     // disable assignment
		
		T pop() 
		{
			std::unique_lock<std::mutex> mlock(mutex_);
			while (queue_.empty())
			{
				cond_.wait(mlock);
			}
			auto val = queue_.front();
			queue_.pop();
			return val;
		}

		void push(const T& item)
		{
			std::unique_lock<std::mutex> mlock(mutex_);
			queue_.push(item);
			mlock.unlock();
			cond_.notify_one();
		}
		
		size_t size()
		{
			std::unique_lock<std::mutex> mlock(mutex_);
			return queue_.size();
		}
  
	   private :
	    std::queue<T> queue_;
		std::mutex mutex_;
		std::condition_variable cond_;
	};

#endif